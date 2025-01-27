import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/domain/usecases/rate/add_customer_rate_usecase.dart';
import 'package:alqaysar_rates/features/domain/usecases/customer/add_customer_usecase.dart';
import 'package:alqaysar_rates/features/domain/usecases/customer/delete_customer_usecase.dart';
import 'package:alqaysar_rates/features/domain/usecases/rate/get_customer_rate._usecase.dart';
import 'package:alqaysar_rates/features/domain/usecases/customer/get_customers_usecase.dart';
import 'package:alqaysar_rates/features/domain/usecases/customer/update_customer_name_usecase.dart';
import 'package:alqaysar_rates/features/ui/common/comment_item_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../service_locator.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';

class CommentsScreen extends StatelessWidget {
  final String customerName;
  final int customerId;
  const CommentsScreen({
    Key? key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 55.0),
                  child: Text(
                    customerName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.sp),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
                indent: 70,
                endIndent: 70,
              ),
              Expanded(
                flex: 9,
                child: BlocProvider(
                  create: (context) => CustomerCubit(
                      deleteCustomerUsecase: sl<DeleteCustomerUsecase>(),
                      updateCustomerNameUsecase:sl<UpdateCustomerNameUsecase>(),
                      getCustomersUsecase: sl<GetCustomersUsecase>(),
                      addCustomerUsecase:  sl<AddCustomerUsecase>(),
                      addCustomerRateUsecase:  sl<AddCustomerRateUsecase>(),
                      getCustomerRateUseCase: sl<GetCustomerRateUseCase>()
                  )..fetchCustomerRates(customerId),
                  child: BlocBuilder<CustomerCubit, CustomerState>(
                    builder: (context, state) {
                      if (state is CustomerLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CustomerRateLoaded) {
                        final rates = state.rates;
                         if(rates.length>0)
                          return ListView.builder(
                          itemCount: rates.length,
                          itemBuilder: (context, index) {
                            final rate = rates[index];
                            String emojiPath;
                            String rateTr;
                            if (rate.rate=='excellent') {
                              emojiPath = ImageAssets.emojiExcellent;
                              rateTr=AppStrings.excellent.tr();
                            } else if (rate.rate == 'good') {
                              emojiPath = ImageAssets.emojiGood;
                              rateTr=AppStrings.good.tr();
                            } else if(rate.rate=='poor'){
                              emojiPath = ImageAssets.emojiWeek;
                              rateTr=AppStrings.weak.tr();
                            }else if(rate.rate=='veryGood'){
                              emojiPath = ImageAssets.emojiVeryGood;
                              rateTr=AppStrings.veryGood.tr();
                            }else{
                              emojiPath = ImageAssets.emojiBad;
                              rateTr=AppStrings.bad.tr();
                            }
                            return CommentItemDesign(
                              phone: rate.phone ??AppStrings.noPhone.tr(),
                              comment: rate.comment ?? AppStrings.noComment.tr(),
                              imagePath: emojiPath,
                              screenType: "comment",
                              customerName: customerName,
                              rate:rateTr,
                            );
                          },
                        );
                         else  return Center(child: Text(AppStrings.noRateAvailable.tr()));
                      } else if (state is CustomerError) {
                        return Center(child: Text(state.message));
                      }
                      return Center(child: Text(AppStrings.noRateAvailable.tr()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
