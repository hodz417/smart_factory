// lib/features/home/home_page.dart
import 'package:ai_factory/core/constant/app_assets.dart';
import 'package:ai_factory/feature/data/model/feature_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ai_factory/core/constant/theme/app_colors.dart';
import 'package:ai_factory/core/constant/theme/app_text_styles.dart';

import 'package:ai_factory/feature/data/helper/link_helper.dart';
import 'package:ai_factory/feature/ui/widgets/feature_card.dart';
import 'package:ai_factory/feature/ui/widgets/lunch_feature_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<HomeAction> get _actions => const [
        HomeAction(title: 'Face Recognition',   image: AppAssets.face,    target: 'http://localhost:8507'),
        HomeAction(title: 'Fire Detection',      image: AppAssets.fire,    target: 'http://localhost:8502'),
        HomeAction(title: 'Burn App',            image: AppAssets.burn,    target: 'http://localhost:8505'),
        HomeAction(title: 'Uniform Detection',   image: AppAssets.uniform, target: 'http://localhost:8506'),
        HomeAction(title: 'Phone Use',           image: AppAssets.phone,   target: 'http://localhost:8504'),
        HomeAction(title: 'Product Detection',   image: AppAssets.product, target: 'http://localhost:8503'),
        HomeAction(title: 'CV Detection',        image: AppAssets.cv,      target: 'http://localhost:8501'),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          itemCount: _actions.length + 1, // +1 for header
          itemBuilder: (context, index) {
            // Header
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.fromLTRB(25.w, 0, 16.w, 8.h),
                child: Text(
                  'AI Factory is with you to manage your own project',
                  style: AppTextStyles.h2,
                ),
              );
            }

            // Items
            final action = _actions[index - 1];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Column(
                children: [
                  FeatureCard(imagePath: action.image),
                  SizedBox(height: 12.h),
                  LunchFeatureButton(
                    label: action.title,
                    onPressed: () async {
                      final res = await LinkHelper.open(context, action.target);
                      res.fold(
                        (failure) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              failure.message,
                              style: AppTextStyles.body.copyWith(color: Colors.white),
                            ),
                            backgroundColor: AppColors.error,
                          ),
                        ),
                        (_) {},
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
