import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../common/comment_item_design.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';

class NegativeScreen extends StatefulWidget {
  @override
  _NegativeScreenState createState() => _NegativeScreenState();
}

class _NegativeScreenState extends State<NegativeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerCubit>().fetchNegativeRates();
  }

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
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading) {
              return Skeletonizer(
                enabled: true,
                effect: ShimmerEffect(
                  baseColor: AppColors.primaryColor[1],
                  highlightColor: AppColors.primaryColor[0],
                ),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => CommentItemDesign(
                    phone: AppStrings.noPhone.tr(),
                    comment: AppStrings.noComment.tr(),
                    imagePath: ImageAssets.emojiExcellent,
                    screenType: "comment",
                    customerName: "ahmed sobhi",
                    rate: AppStrings.excellent.tr(),
                  ),
                ),
              );
            } else if (state is CustomerRateLoaded) {
              final rates = state.rates;
              if (rates.isNotEmpty) {
                return ListView.builder(
                  itemCount: rates.length,
                  itemBuilder: (context, index) {
                    final rate = rates[index];
                    String emojiPath;
                    String rateTr;
                    if (rate.rate == 'excellent') {
                      emojiPath = ImageAssets.emojiExcellent;
                      rateTr = AppStrings.excellent.tr();
                    } else if (rate.rate == 'good') {
                      emojiPath = ImageAssets.emojiGood;
                      rateTr = AppStrings.good.tr();
                    } else if (rate.rate == 'poor') {
                      emojiPath = ImageAssets.emojiWeek;
                      rateTr = AppStrings.weak.tr();
                    } else if (rate.rate == 'veryGood') {
                      emojiPath = ImageAssets.emojiVeryGood;
                      rateTr = AppStrings.veryGood.tr();
                    } else {
                      emojiPath = ImageAssets.emojiBad;
                      rateTr = AppStrings.bad.tr();
                    }
                    return CommentItemDesign(
                      phone: rate.phone ?? AppStrings.noPhone.tr(),
                      comment:
                      rate.comment ?? AppStrings.noComment.tr(),
                      imagePath: emojiPath,
                      screenType: "negative",
                      customerName: rate.customerName??"not found",
                      rate: rateTr,
                    );
                  },
                );
              }

            } else if (state is CustomerError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text(AppStrings.noRateAvailable.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),));
          },
        ),
      ),
    );
  }
}
