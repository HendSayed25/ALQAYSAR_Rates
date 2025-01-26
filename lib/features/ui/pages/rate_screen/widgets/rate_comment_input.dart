import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/language/language_helper.dart';
import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/strings.dart';

class RateCommentInput extends StatelessWidget {
  final TextEditingController controller;

  const RateCommentInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 210.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryContainerColor,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textDirection: AppLanguages.getCurrentTextDirection(context),
        style: TextStyle(
          fontFamily: AppLanguages.getPrimaryFont(context),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        maxLines: 7,
        decoration: InputDecoration(
          hintText: AppStrings.enterYourCommentHere,
          contentPadding: EdgeInsets.only(left: 10.w, top: 70.h),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
