import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/features/domain/entities/rate_entity.dart';
import 'package:alqaysar_rates/features/ui/pages/user_over_view/widgets/chart_rate_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helper/data_intent.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../common/bottom_sheet_design.dart';
import '../../common/custom_button.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';

class UserOverViewScreen extends StatefulWidget {
  const UserOverViewScreen({super.key});

  @override
  State<UserOverViewScreen> createState() => _UserOverViewScreenState();
}

class _UserOverViewScreenState extends State<UserOverViewScreen> {
  late CustomerEntity customer;
  late List<RateEntity> customerRate;

  @override
  void initState() {
    super.initState();
    customer = DataIntent.customer;
    context.read<CustomerCubit>().fetchCustomerRates(customer.id!);
  }

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
            Container(
              margin: EdgeInsets.only(top: 40.h),
              child: BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  return Text(
                    customer.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25.h),
            BlocBuilder<CustomerCubit, CustomerState>(
              builder: (context, state) {
                if (state is CustomerRateLoaded) {
                  customerRate = state.rates;

                  double excellentCount = 0;
                  double goodCount = 0;
                  double veryGoodCount = 0;
                  double badCount = 0;
                  double weakCount = 0;
                  int totalCount = customerRate.length == 0 ? 1 : customerRate.length;

                  for (var rate in customerRate) {
                    if (rate.rate == 'excellent') {
                      excellentCount++;
                    } else if (rate.rate == 'good') {
                      goodCount++;
                    } else if (rate.rate == 'veryGood') {
                      veryGoodCount++;
                    } else if (rate.rate == 'poor') {
                      weakCount++;
                    } else {
                      badCount++;
                    }
                  }
                  return RatingChart(
                    values: [
                      excellentCount,
                      veryGoodCount,
                      goodCount,
                      weakCount,
                      badCount,
                    ],
                    customerName: customer.name,
                    customerId: customer.id!,
                  );
                } else if (state is CustomerError) {
                  return Center(
                    child: Text("Error: ${state.message}"),
                  );
                }
                  return Skeletonizer(
                    enabled: true,
                    effect: ShimmerEffect(
                      baseColor: AppColors.primaryColor[1],
                      highlightColor: AppColors.primaryColor[0],
                    ),
                    child: RatingChart(
                      values: [100, 100, 100, 100, 100],
                      customerName: customer.name,
                      customerId: customer.id!,
                    ),
                  );
              },
            ),
            SizedBox(height: 60.h),
            BlocConsumer<CustomerCubit, CustomerState>(
              listener: (context, state) {
                if (state is CustomerNameUpdatedSuccessfully) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                      content: Text(
                        AppStrings.customerEditedSuccessfully.tr(),
                      ),
                    ),
                  );
                  customer = state.customer;
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
                    colors: AppColors.primaryContainerColor,
                  ),
                  colorOfBorder: Colors.yellow,
                  text: AppStrings.edit.tr(),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0.r),
                        ),
                      ),
                      builder: (_) {
                        return BottomSheetDesign(
                          textBtn: AppStrings.edit.tr(),
                          inputTextValue: customer.name,
                          onPressed: (String name) {
                            if (name.isNotEmpty) {
                              context.read<CustomerCubit>().updateCustomerName(
                                CustomerEntity(name: name, id: customer.id),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                    AppStrings.nameRequired.tr(),
                                  ),
                                ),
                              );
                            }
                          },
                          isLoading: state is CustomerLoading,
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 30.h),
            BlocConsumer<CustomerCubit, CustomerState>(
              listener: (context, state) {
                if (state is CustomerDeletedSuccessfully) {
                  context.pushNamedAndRemoveUntil(
                    Routes.showAllRoute,
                    predicate: (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                      content: Text(
                        AppStrings.deleteSuccess.tr(),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryContainerColor,
                  ),
                  colorOfBorder: Colors.red,
                  text: AppStrings.delete.tr(),
                  onPressed: () {
                    context.read<CustomerCubit>().deleteCustomer(customer.id!);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
