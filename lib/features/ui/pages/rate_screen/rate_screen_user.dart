import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/ui/common/custom_button.dart';
import 'package:alqaysar_rates/features/ui/pages/rate_screen/widgets/emojy_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/colors_manager.dart';

class RateScreenUser extends StatelessWidget {
  const RateScreenUser({super.key});

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
                    decoration:  BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryContainerColor,
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35),bottomRight:  Radius.circular(35)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2.r,
                            blurRadius: 8.r,
                            offset: const Offset(0, 4),
                          ),
                        ]
                    ),
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
                  margin: const EdgeInsets.all(40.0),
                  child: Text("User Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,

                    ),)
              ),
              const EmojyDesignWidget(),
              Container(
                width: 380.w,
                height: 210.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryContainerColor,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child:TextField(
                    textAlign: TextAlign.center,
                    textDirection: AppLanguages.getCurrentTextDirection(context),
                    style: TextStyle(fontFamily: AppLanguages.getPrimaryFont(context)),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    maxLines: 7,
                   // maxLength: AppConstants.maxLength,
                    decoration: InputDecoration(
                      hintText: AppStrings.enterYourCommentHere.tr(),
                      contentPadding: const EdgeInsets.only(left: 10.0,top: 70.0),
                      border:InputBorder.none,
                    ),
                ),
              ),
              SizedBox(height: 40.h,),
              CustomButton(
                gradient: const LinearGradient(
                  colors: AppColors.primaryContainerColor,
                ),
                colorOfBorder: Colors.white,
                text: AppStrings.submit.tr(),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text(
                        AppStrings.thanksForRating.tr(),
                        textDirection:AppLanguages.getCurrentTextDirection(context),
                        style: TextStyle(fontFamily: AppLanguages.getPrimaryFont(context)),
                      ),
                    ),
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
