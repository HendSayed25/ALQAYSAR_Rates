import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/language/language_helper.dart';
import '../../../../../core/resource/colors_manager.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          AppStrings.forgetPassword.tr(),
          textDirection: AppLanguages.getCurrentTextDirection(context),
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontFamily: AppLanguages.getPrimaryFont(context)
          ),
        ),
      ),
    );
  }
}
