import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/features/domain/entities/rate_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/helper/data_intent.dart';
import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../common/custom_button.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';
import 'widgets/emoji_design.dart';
import 'widgets/rate_header.dart';
import 'widgets/rate_comment_input.dart';

class RateScreenUser extends StatelessWidget {
  RateScreenUser({super.key});

  final TextEditingController commentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'EG');
  String? selectedRatingCategory;

  @override
  Widget build(BuildContext context) {
    CustomerEntity customer = DataIntent.customer;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is CustomerRateUpdatedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                  AppStrings.thanksForRating.tr(),
                  textDirection: AppLanguages.getCurrentTextDirection(context),
                ),
              ),
            );
            context.pop(); // Go back after successful rating.
          } else if (state is CustomerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                content: Text(
                  AppStrings.errorRating.tr(),
                  textDirection: AppLanguages.getCurrentTextDirection(context),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RatingCategorySelected) {
            selectedRatingCategory = state.category;
          }
          if (state is RatingPhoneNumberUpdated) {
            phoneNumber = state.phoneNumber;
          }

          return Form(
            key: _formKey,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.backgroundColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RateHeader(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50.h),
                    child: Text(
                      customer.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp,
                      ),
                    ),
                  ),
                  EmojiDesignWidget(
                    onEmojiSelected: (category) {
                      context
                          .read<CustomerCubit>()
                          .selectRatingCategory(category);
                    },
                  ),
                  _buildPhoneNumberInput(context),
                  RateCommentInput(controller: commentController),
                  SizedBox(height: 40.h),
                  _buildSubmitButton(
                    context: context,
                    phone: phoneController.text,
                    customerId: customer.id!,
                    state: state,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: AbsorbPointer(
        absorbing: selectedRatingCategory == null,
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            context.read<CustomerCubit>().updatePhoneNumber(number);
          },
          textFieldController: phoneController,
          formatInput: true,
          inputDecoration: InputDecoration(
            hintText: AppStrings.enterPhoneNumber.tr(),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(right: 10.w, bottom: 14.h),
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            setSelectorButtonAsPrefixIcon: false,
          ),
          initialValue: phoneNumber,
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton({
    required BuildContext context,
    String? phone,
    required int customerId,
    required CustomerState state,
  }) {
    return CustomButton(
      gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
      colorOfBorder: AppColors.enableBorderColor,
      text: AppStrings.submit.tr(),
      onPressed: () {
        if (selectedRatingCategory == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              content: Text(
                AppStrings.pleaseRate.tr(),
                textDirection: AppLanguages.getCurrentTextDirection(context),

              ),
            ),
          );
          return;
        }

        final customerRating = RateEntity(
          customerId: customerId,
          comment: commentController.text,
          phone: phone,
          rate: selectedRatingCategory ?? AppStrings.excellent.tr(),
        );

        context.read<CustomerCubit>().updateCustomerRating(customerRating);
      },
      isLoading: state is CustomerLoading,
    );
  }
}
