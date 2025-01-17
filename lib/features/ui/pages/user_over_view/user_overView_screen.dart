import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/ui/common/bottom_sheet_design.dart';
import 'package:alqaysar_rates/features/ui/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../core/config/routes/route_constants.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../service_locator.dart';
import '../../../data/local/app_prefs.dart';
import '../../../domain/entities/customer.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';

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
          padding: EdgeInsets.only(top: 5.0),
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
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35),bottomRight:  Radius.circular(35)),
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
                      margin: EdgeInsets.all(50.0),
                        child: Text("User Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,

                        ),)
                    ),
                 Container(
                   width: 280.w,
                   height: 190.h,
                   decoration:  const BoxDecoration(
                     gradient: LinearGradient(
                       colors: AppColors.primaryContainerColor,
                       begin: Alignment.topLeft,
                       end: Alignment.topRight,
                     ),
                   )

                 ),

                    SizedBox(height: 90.h),
                    CustomButton(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryContainerColor,
                      ),
                      colorOfBorder: Colors.yellow,
                      text: AppStrings.edit,
                      onPressed: () {
                      //  context.pushNamed(Routes.showAllForAdminRoute);
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryContainerColor,
                      ),
                      colorOfBorder: Colors.red,
                      text: AppStrings.delete,
                      onPressed: () {
                        //  context.pushNamed(Routes.showAllForAdminRoute);
                      },
                    ),

                 ],
                ),
        ),
      ),
    );
  }
}
