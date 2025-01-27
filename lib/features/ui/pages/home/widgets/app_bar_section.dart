import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/language/language_helper.dart';
import '../../../../../core/resource/assets_manager.dart';
import '../../../../../core/resource/strings.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin:
              EdgeInsets.only(left: 40.w, top: 70.h, bottom: 10.h, right: 20.w),
          child: GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 40, top: 35, bottom: 10, right: 20),
                child: Image.asset(
                  ImageAssets.languageIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              onTap: () {
                AppLanguages.toggleLocal(context);
              }),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 50.w, top: 70.h, bottom: 10.h, right: 30.w),
          child: Text(
            AppStrings.appName.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppLanguages.getPrimaryFont(context),
            ),
            textDirection: AppLanguages.getCurrentTextDirection(context),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 40.w, top: 70.h, bottom: 10.h, right: 10.w),
          child: Image.asset(
            ImageAssets.searchIcon,
            width: 25.w,
            height: 25.h,
          ),
        ),
      ],
    );
  }
}
