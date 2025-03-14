import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../../service_locator.dart';
import '../../../data/local/app_prefs.dart';

class SelectionScreen extends StatelessWidget {
  final String? screenType,userType;
  SelectionScreen({Key? key, required this.screenType,required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.backgroundColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.h,horizontal: 10.w),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 50.w, top: 70.h, bottom: 10.h, right: 30.w),
              child: Text(
                AppStrings.appName.tr(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: AppLanguages.getCurrentTextDirection(context),
              ),
            ),
            SizedBox(
              height: 180.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if(userType=="user")sl<AppPrefs>().setInt("branch",1); //to show selection screen once in the start of app for user
                    context.pushNamed(screenType!,
                        arguments: 1);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        ImageAssets.selectionIcon,
                        width: 120.w,
                        height: 120.h,
                      ),
                      Text(
                        AppStrings.firstBranch.tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 50.w,),
                GestureDetector(
                  onTap: () {
                    if(userType=="user")sl<AppPrefs>().setInt("branch",2); //to show selection screen once in the start of app for user
                    context.pushNamed(screenType!,
                        arguments: 2);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        ImageAssets.selectionIcon,
                        width: 120.w,
                        height: 120.h,
                      ),
                      Text(
                        AppStrings.secondBranch.tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
