import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/strings.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.searchScreenRoute,arguments: 0);
      },
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.black,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: IgnorePointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.search.tr(),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    textDirection:
                        AppLanguages.getCurrentTextDirection(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
