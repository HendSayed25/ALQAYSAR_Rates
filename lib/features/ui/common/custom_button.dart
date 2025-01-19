import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    this.colorOfBorder,
    this.backgroundColor,
    this.gradient,
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
  final Color? colorOfBorder;
  final Gradient? gradient;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300.w,
      height: height ?? 50.h,
      margin: margin,
      decoration: BoxDecoration(
        gradient: gradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          side: BorderSide(color: colorOfBorder ?? Colors.transparent),
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
                        fontFamily: AppLanguages.getPrimaryFont(context)
                      ),
                  textDirection: AppLanguages.getCurrentTextDirection(context),
                ),
      ),
    );
  }
}
