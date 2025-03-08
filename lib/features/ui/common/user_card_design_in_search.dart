import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/assets_manager.dart';

class UserCardInSearch extends StatelessWidget {
  final String userName;
  final double rating;
  final String branch;

  const UserCardInSearch({
    super.key,
    required this.userName,
    required this.rating,
    required this.branch
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 25.0.h, left: 18.w, right: 18.w),
          padding: EdgeInsets.all(15.0.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(33.r),
              bottomRight: Radius.circular(33.r),
              topLeft: Radius.circular(33.r),
              topRight: Radius.circular(33.r),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                ImageAssets.person,
                width: 180.w,
                height: 160.h,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: AppLanguages.getCurrentTextDirection(context),
                    ),
                    SizedBox(height: 6.h),
                    Text(branch,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      textDirection: AppLanguages.getCurrentTextDirection(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
