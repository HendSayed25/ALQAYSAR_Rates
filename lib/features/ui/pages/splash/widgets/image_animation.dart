import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageAnimation extends StatelessWidget {
  const ImageAnimation({
    super.key,
    required Animation<Offset> imageAnimation,
  }) : _imageAnimation = imageAnimation;

  final Animation<Offset> _imageAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _imageAnimation,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Image.asset(
            'assets/images/logo.png',
            width: 200.w,
            height: 243.h,
          ),
        ),
      ),
    );
  }
}
