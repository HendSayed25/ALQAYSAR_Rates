import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/colors_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.child,
    this.isLoading = false,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.textStyle,
  });

  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300.w,
      height: height ?? 50.h,
      margin: margin,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
        borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : child ??
                Text(
                  text!,
                  style: textStyle ??
                      TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                ),
      ),
    );
  }
}
