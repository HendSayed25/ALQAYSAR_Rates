import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/routes/route_constants.dart';
import '../../../../../core/resource/assets_manager.dart';
import '../../../../../core/resource/colors_manager.dart';

class HomeScreenAppBarWidget extends StatelessWidget{

  final int branch;
  const HomeScreenAppBarWidget({super.key,required this.branch});
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Container(
                  child: Image.asset(
                    ImageAssets.languageIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
                onTap: (){
                  AppLanguages.toggleLocal(context);
                }
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  AppStrings.appName.tr(),
                  textDirection: AppLanguages.getCurrentTextDirection(context),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                     ),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.search,color: Colors.white,size: 35.r),
                  onPressed: () {
                    context.pushNamed(Routes.searchScreenRoute,arguments: branch);
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }

}