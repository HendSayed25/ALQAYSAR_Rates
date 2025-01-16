import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/assets_manager.dart';

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
      width: 200.w,
      height: 180.h,
      decoration: BoxDecoration(
        color: AppColors.secondaryContainerColor,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.person,
            width: 100.w,
            height: 100.h,
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Display the rating only if `showRating` is true
          if (showRating) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
