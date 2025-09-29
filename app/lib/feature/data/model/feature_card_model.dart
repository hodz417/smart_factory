import 'package:flutter/foundation.dart';

@immutable
class HomeAction {
  final String title;
  final String image;  // asset or network path
  final String target; // url or named route

  const HomeAction({
    required this.title,
    required this.image,
    required this.target,
  });
}
