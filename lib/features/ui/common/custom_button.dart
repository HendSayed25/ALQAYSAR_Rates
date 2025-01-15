import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/colors_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 333.w,
        height: 60.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
        ),
      );
  }
}
