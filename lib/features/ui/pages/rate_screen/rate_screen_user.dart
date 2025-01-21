import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/extensions.dart';
import '../../../../core/helper/data_intent.dart';
import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer.dart';
import '../../common/custom_button.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';
import 'widgets/emoji_design.dart';
import 'widgets/rate_header.dart';
import 'widgets/rate_comment_input.dart';

class RateScreenUser extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  String? selectedRatingCategory;

  RateScreenUser({super.key});

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
            RateHeader(customer: customer),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.h),
              child: Text(
                customer.name ?? "Unknown User",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                ),
              ),
            ),
            EmojiDesignWidget(
              onEmojiSelected: (category) {
                selectedRatingCategory = category;
              },
            ),
            RateCommentInput(controller: commentController),
            SizedBox(height: 40.h),
            _buildSubmitButton(context, customer),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, Customer customer) {
    return BlocConsumer<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is CustomerUpdatedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppStrings.thanksForRating.tr(),
                textDirection: AppLanguages.getCurrentTextDirection(context),
                style: TextStyle(
                  fontFamily: AppLanguages.getPrimaryFont(context),
                ),
              ),
            ),
          );
          context.pop();
        } else if (state is CustomerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppStrings.errorRating.tr(),
                textDirection: AppLanguages.getCurrentTextDirection(context),
                style: TextStyle(
                  fontFamily: AppLanguages.getPrimaryFont(context),
                ),
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
          colorOfBorder: AppColors.enableBorderColor,
          text: AppStrings.submit.tr(),
          onPressed: () {
            if (selectedRatingCategory == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Please select a rating before submitting.",
                    textDirection:
                        AppLanguages.getCurrentTextDirection(context),
                    style: TextStyle(
                      fontFamily: AppLanguages.getPrimaryFont(context),
                    ),
                  ),
                ),
              );
              return;
            }

            final updatedCustomer = Customer(
              id: customer.id,
              name: customer.name,
              comments: [commentController.text],
              uncooperative: selectedRatingCategory == 'uncooperative' ? 1 : 0,
              poor: selectedRatingCategory == 'poor' ? 1 : 0,
              good: selectedRatingCategory == 'good' ? 1 : 0,
              veryGood: selectedRatingCategory == 'veryGood' ? 1 : 0,
              excellent: selectedRatingCategory == 'excellent' ? 1 : 0,
            );

            context.read<CustomerCubit>().updateCustomer(updatedCustomer);
          },
          isLoading: state is CustomerLoading,
        );
      },
    );
  }
}
