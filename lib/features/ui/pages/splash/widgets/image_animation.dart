import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageAnimation extends StatelessWidget {
  const ImageAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssets.logo,
      width: 200.w,
      height: 243.h,
    )
        .animate()
        .slideX(begin: 1, end: -0.5, duration: 2.seconds)
        .fadeIn(duration: 1.seconds);
  }
}
