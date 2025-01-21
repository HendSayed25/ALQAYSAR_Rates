import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/data_intent.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer.dart';
import '../../common/custom_button.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';
import 'widgets/chart_rate_design.dart';

class UserOverViewScreen extends StatelessWidget {
  const UserOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Customer customer = DataIntent.customer;

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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      width: 160.w,
                      height: 176.h,
                      ImageAssets.person,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: Text(
                (customer.name ?? "Unknown User").toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                ),
              ),
            ),
            SizedBox(
              width: 280,
              height: 280,
              child: PieChartSample2(
                values: [
                  customer.rateOfExcellent,
                  customer.rateOfVeryGood,
                  customer.rateOfGood,
                  customer.rateOfPoor,
                  customer.rateOfUncooperative
                ],
                colors: const [
                  Colors.blue,
                  Colors.yellow,
                  Colors.purple,
                  Colors.green,
                  Colors.red,
                ],
              ),
            ),
            SizedBox(height: 60.h),
            BlocConsumer<CustomerCubit, CustomerState>(
              listener: (context, state) {},
              builder: (context, state) {
                return CustomButton(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryContainerColor,
                  ),
                  colorOfBorder: Colors.yellow,
                  text: AppStrings.edit.tr(),
                  onPressed: () {},
                );
              },
            ),
            SizedBox(height: 30.h),
            BlocConsumer<CustomerCubit, CustomerState>(
              listener: (context, state) {},
              builder: (context, state) {
                return CustomButton(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryContainerColor,
                  ),
                  colorOfBorder: Colors.red,
                  text: AppStrings.delete.tr(),
                  onPressed: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
