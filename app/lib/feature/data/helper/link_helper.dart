// lib/core/link_helper.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

sealed class LinkFailure {
  final String message;
  const LinkFailure(this.message);
}

final class InvalidUrl extends LinkFailure {
  const InvalidUrl(String msg) : super(msg);
}

final class CannotLaunch extends LinkFailure {
  const CannotLaunch(String msg) : super(msg);
}

final class LinkHelper {
  const LinkHelper._();

  /// Launches external URLs. Returns Either<Failure, Unit>.
  static Future<Either<LinkFailure, Unit>> launchExternal(String urlString) async {
    try {
      final uri = Uri.tryParse(urlString);
      if (uri == null) return left(InvalidUrl('Invalid URL: $urlString'));

      if (!await canLaunchUrl(uri)) {
        return left(CannotLaunch('Cannot launch: $urlString'));
      }

      final ok = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      return ok ? right(unit) : left(CannotLaunch('Launch failed: $urlString'));
    } catch (e) {
      return left(CannotLaunch('Unexpected error: $e'));
    }
  }

  /// Example helper to navigate by route name OR launch URL if it looks like http(s).
  static Future<Either<LinkFailure, Unit>> open(
    BuildContext context,
    String target, {
    Object? arguments,
  }) async {
    final isUrl = target.startsWith('http://') || target.startsWith('https://');
    if (isUrl) return launchExternal(target);

    // treat as a named route
    try {
      await Navigator.of(context).pushNamed(target, arguments: arguments);
      return right(unit);
    } catch (e) {
      return left(CannotLaunch('Route navigation failed: $e'));
    }
  }
}
