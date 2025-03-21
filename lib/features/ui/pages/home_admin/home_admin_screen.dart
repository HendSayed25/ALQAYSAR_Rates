import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../core/config/routes/route_constants.dart';
import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../common/bottom_sheet_design.dart';
import '../../common/custom_button.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';
import 'widgets/search_bar.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.hiAdmin.tr(),
                        textDirection:
                            AppLanguages.getCurrentTextDirection(context),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,),
                      ),
                    ),
                    SizedBox(height: 90.h),
                    Center(
                      child: Image.asset(
                        ImageAssets.logo,
                        width: 200.w,
                        height: 200.h,
                      ),
                    ),
                    SizedBox(height: 100.h),
                    GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.searchScreenRoute,arguments: {0});//branch=0 => means show all in two branches
                        },
                        child: const SearchBarWidget()),
                    SizedBox(height: 100.h),
                    CustomButton(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryContainerColor,
                      ),
                      colorOfBorder: Colors.transparent,
                      text: AppStrings.showAll.tr(),
                      onPressed: () {
                        context.pushNamed(Routes.selectionScreen,arguments: {
                          "screenType": Routes.showAllRoute,
                          "userType":"admin"});
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      onPressed: () {
                       // context.pushNamed(Routes.negativeScreen);
                        context.pushNamed(Routes.selectionScreen,
                            arguments: {
                            "screenType": Routes.negativeScreen,
                            "userType":"admin"});

                      },
                      gradient: const LinearGradient(
                          colors: AppColors.primaryContainerColor),
                      colorOfBorder: Colors.transparent,
                      text: AppStrings.showNegativeRates.tr(),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    BlocConsumer<CustomerCubit, CustomerState>(
                      listener: (context, state) {
                        Logger().i(state);
                        if (state is CustomerAddedSuccessfully) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                              content: Text(
                                AppStrings.customerAddedSuccessfully.tr(),
                                textDirection:
                                    AppLanguages.getCurrentTextDirection(
                                        context),

                            ),
                          ));
                        } else if (state is CustomerError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          gradient: const LinearGradient(
                              colors: AppColors.primaryContainerColor),
                          colorOfBorder: Colors.transparent,
                          text: AppStrings.add.tr(),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.r),
                                ),
                              ),
                              builder: (_) {
                                return BottomSheetDesign(
                                  textBtn: AppStrings.add.tr(),
                                  onPressed: (String name,int branch) {
                                    if (name.isNotEmpty&& branch!=0) {
                                      context
                                          .read<CustomerCubit>()
                                          .addNewCustomer(
                                            CustomerEntity(name: name,branch: branch),
                                          );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 2),
                                          content: Text(
                                            AppStrings.nameRequiredAndBranch.tr(),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                          isLoading: state is CustomerLoading,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
