import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return Center(child: CircularProgressIndicator());
            }
            if (state is CustomerError) {
             return Center(child: Text(state.message));
            }

            if (state is CustomerRateLoaded) {
              final negativeRates = state.rates;

              return ListView.builder(
                itemCount: negativeRates.length,
                itemBuilder: (context, index) {
                  final rate = negativeRates[index];
                  String emojiPath;
                  if (rate.rate == 'poor') {
                    emojiPath = ImageAssets.emojiWeek;
                  } else {
                    emojiPath = ImageAssets.emojiBad;
                  }

                  return CommentItemDesign(
                    phone: rate.phone ?? AppStrings.noPhone.tr(),
                    comment: rate.comment??"",
                    imagePath: emojiPath,
                    screenType: "negative",
                    customerName:rate.customerName ?? 'not found',
                    rate: rate.rate.tr(),
                  );
                },
              );
            }

            return Center(child: Text(AppStrings.noRateAvailable.tr()));
          },
        ),
      ),
    );
  }
}
