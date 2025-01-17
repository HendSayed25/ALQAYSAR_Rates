import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/assets_manager.dart';
import '../../../core/resource/colors_manager.dart';

class UserCard extends StatelessWidget {
  final String userName;
  final double rating;
  final bool showRating;

  const UserCard({
    super.key,
    required this.userName,
    required this.showRating,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.w,
      height: 216.h,
      decoration: BoxDecoration(
        color: AppColors.secondaryContainerColor,
        borderRadius: BorderRadius.circular(33.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2.r,
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 147.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.primaryContainerColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(33.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Image.asset(
                ImageAssets.person,
                width: 135.w,
                height: 135.h,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextColor,
            ),
          ),
          showRating
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${rating.toStringAsFixed(1)} / 5",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.r,
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
