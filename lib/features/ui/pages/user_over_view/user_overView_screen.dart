import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/ui/common/bottom_sheet_design.dart';
import 'package:alqaysar_rates/features/ui/common/custom_button.dart';
import 'package:alqaysar_rates/features/ui/pages/user_over_view/widgets/chart_rate_design.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';

class UserOverViewScreen extends StatelessWidget {
  const UserOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300.h,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryContainerColor,
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2.r,
                            blurRadius: 8.r,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: Container(
                      padding: const EdgeInsets.all(50.0),
                      width: 50.w,
                      height: 50.h,
                      child: Image.asset(
                        ImageAssets.person,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(
                    "User Name",
                    style: TextStyle(
                      fontFamily: AppLanguages.getPrimaryFont(context),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,
                    ),
                  )),
              Center(
                child: SizedBox(
                  width: 270.w,
                  height: 270.h,
                  child: const FittedBox(
                    child: SizedBox(
                        width: 280, height: 280, child: PieChartSample2()),
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              CustomButton(
                gradient: const LinearGradient(
                  colors: AppColors.primaryContainerColor,
                ),
                colorOfBorder: Colors.yellow,
                text: AppStrings.edit.tr(),
                onPressed: () {},
              ),
              SizedBox(height: 30.h),
              CustomButton(
                gradient: const LinearGradient(
                  colors: AppColors.primaryContainerColor,
                ),
                colorOfBorder: Colors.red,
                text: AppStrings.delete.tr(),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
