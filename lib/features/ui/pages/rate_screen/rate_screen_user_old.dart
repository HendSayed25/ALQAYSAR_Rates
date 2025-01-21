import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../common/custom_button.dart';
import 'widgets/emoji_design.dart';

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
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35.r),
                        bottomRight: Radius.circular(35.r),
                      ),
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
                margin: EdgeInsets.all(40.r),
                child: Text(
                  "User Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.sp,
                  ),
                )),
            const EmojiDesignWidget(),
            Container(
              width: 380.w,
              height: 210.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryContainerColor,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                textDirection: AppLanguages.getCurrentTextDirection(context),
                style:
                    TextStyle(fontFamily: AppLanguages.getPrimaryFont(context)),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                maxLines: 7,
                // maxLength: AppConstants.maxLength,
                decoration: InputDecoration(
                  hintText: AppStrings.enterYourCommentHere.tr(),
                  contentPadding: EdgeInsets.only(left: 10.w, top: 70.h),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              gradient: const LinearGradient(
                colors: AppColors.primaryContainerColor,
              ),
              colorOfBorder: AppColors.enableBorderColor,
              text: AppStrings.submit.tr(),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppStrings.thanksForRating.tr(),
                      textDirection:
                          AppLanguages.getCurrentTextDirection(context),
                      style: TextStyle(
                        fontFamily: AppLanguages.getPrimaryFont(context),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
