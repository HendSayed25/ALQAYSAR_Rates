import 'package:flutter/material.dart';

import '../../../../../core/resource/colors_manager.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Forget Password?",
          style: TextStyle(
            color: AppColors.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
