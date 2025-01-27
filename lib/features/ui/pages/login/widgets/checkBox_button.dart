import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/data/local/app_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../service_locator.dart';

class CheckBoxWidget extends StatefulWidget {
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.h,vertical: 10.h),
      child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  sl<AppPrefs>().setBool("remember", true);
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
                    border: Border.all(
                      color: AppColors.enableBorderColor,
                      width: 2.w,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isChecked
                      ?  Icon(
                    Icons.check,
                    size: 15.sp,
                    color: Colors.black,
                  )
                      : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Text(
                  AppStrings.rememberMe.tr(),
                  style: TextStyle(fontSize: 15.sp,color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }
}
