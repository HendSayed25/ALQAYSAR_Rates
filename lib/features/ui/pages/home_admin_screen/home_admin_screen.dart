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
                            color: Colors.black,
                            fontFamily: AppLanguages.getPrimaryFont(context)),
                      ),
                    ),
                    SizedBox(height: 95.h),
                    Center(
                      child: Image.asset(
                        ImageAssets.logo,
                        width: 200.w,
                        height: 200.h,
                      ),
                    ),
                    SizedBox(height: 112.h),
                    GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.searchScreenRoute);
                        },
                        child: const SearchBarWidget()),
                    SizedBox(height: 107.h),
                    CustomButton(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryContainerColor,
                      ),
                      colorOfBorder: Colors.transparent,
                      text: AppStrings.showAll.tr(),
                      onPressed: () {
                        context.pushNamed(Routes.showAllRoute);
                      },
                    ),
                    SizedBox(height: 30.h),
                    BlocConsumer<CustomerCubit, CustomerState>(
                      listener: (context, state) {
                        Logger().e(state);
                        if (state is CustomerAddedSuccessfully) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppStrings.customerAddedSuccessfully.tr(),
                                textDirection:
                                    AppLanguages.getCurrentTextDirection(
                                        context),
                                style: TextStyle(
                                    fontFamily:
                                        AppLanguages.getPrimaryFont(context)),
                              ),
                            ),
                          );
                        } else if (state is CustomerError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
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
                                  onPressed: (String name) {
                                    if (name.isNotEmpty) {
                                      context
                                          .read<CustomerCubit>()
                                          .addNewCustomer(
                                            CustomerEntity(name: name),
                                          );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            AppStrings.nameRequired.tr(),
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
