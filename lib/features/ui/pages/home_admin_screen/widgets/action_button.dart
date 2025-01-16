import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../common/custom_button.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.text, required this.onPressed, bool? isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 50.h,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryContainerColor,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: CustomButton(
        gradient: const LinearGradient(
          colors: AppColors.primaryColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        text: text,
        onPressed: onPressed,
      ),
    );
  }
}