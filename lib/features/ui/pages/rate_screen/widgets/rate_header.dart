import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/assets_manager.dart';
import '../../../../../core/resource/colors_manager.dart';

class RateHeader extends StatelessWidget {

  const RateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 215.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryContainerColor,
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.r),
          bottomRight: Radius.circular(35.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2.r,
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(50.r),
        width: 50.w,
        height: 50.h,
        child: Image.asset(
          ImageAssets.person,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}