import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/assets_manager.dart';

class UserCardInSearch extends StatelessWidget {
  final String userName;
  final double rating;
  final bool showRating;

  const UserCardInSearch({
    super.key,
    required this.userName,
    required this.showRating,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 180.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryContainerColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 70,
            top: 0.1,
            child: Container(
              width: 300.w,
              height: 180.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryContainerColor,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(38),
                  bottomRight: Radius.circular(38),
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryContainerColor,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Image.asset(
                    ImageAssets.person,
                    width: 80.w,
                    height: 80.h,
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (showRating) ...[
                      Row(
                        children: [
                          Text(
                            "$rating / 5",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(width: 5.w),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
