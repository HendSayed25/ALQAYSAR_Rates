import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/colors_manager.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.login.tr(),
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textDirection: AppLanguages.getCurrentTextDirection(context),
        ),
        SizedBox(height: 8.h),
        Text(
          AppStrings.enterEmailPassword.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.primaryTextColor,
          ),
          textDirection: AppLanguages.getCurrentTextDirection(context),
        ),
        SizedBox(height: 126.h),
      ],
    );
  }
}