import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/data_intent.dart';
import '../../../../../core/helper/validation.dart';
import '../../../../../core/resource/colors_manager.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 333.w,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextFormField(
            controller: emailController,
            focusNode: emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(color: AppColors.enableBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(color: AppColors.disableBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.errorColor),
              ),
              errorMaxLines: 2,
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            validator: (value) => Validation.validateEmail(value),
            onChanged: (email){DataIntent.pushEmail(email);},
          ),
        ),
        SizedBox(height: 33.h),
        Container(
          width: 333.w,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextFormField(
            controller: passController,
            focusNode: passwordFocusNode,
            // Set focusNode for this field
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(color: AppColors.enableBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(color: AppColors.disableBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColors.errorColor),
              ),
              errorMaxLines: 2,
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            ),
            // validator: (value) => Validation.validatePassword(value),
            onChanged: (password){DataIntent.pushPassword(password);},
          ),
        ),
      ],
    );
  }
}
