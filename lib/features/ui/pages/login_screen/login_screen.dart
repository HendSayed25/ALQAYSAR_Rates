import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../core/config/routes/route_constants.dart';
import '../../../../core/helper/data_intent.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../../service_locator.dart';
import '../../../data/local/app_prefs.dart';
import '../../common/custom_button.dart';
import '../../cubit/login_cubit.dart';
import '../../states/login_state.dart';
import 'widgets/forget_password_button.dart';
import 'widgets/login_header.dart';
import 'widgets/form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LoginHeader(),
                      const MyForm(),
                      SizedBox(height: 8.h),
                      const ForgetPasswordButton(),
                      SizedBox(height: 100.h),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthAuthenticated) {
                            sl<AppPrefs>().setString("id", state.userEntity.id);
                            sl<AppPrefs>()
                                .setString("role", state.userEntity.role);

                            Logger().i(
                                "${state.userEntity.email} + ${state.userEntity.id} + ${state.userEntity.role}");

                            if (state.userEntity.role == "user") {
                              context.pushReplacementNamed(
                                  Routes.homeScreenUserRoute);
                            } else {
                              context.pushReplacementNamed(
                                  Routes.homeScreenAdminRoute);
                            }
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppStrings.emailPasswordError.tr(),
                                  textDirection: AppLanguages.getCurrentTextDirection(context),
                                  style: TextStyle(fontFamily: AppLanguages.getPrimaryFont(context)),
                                ),
                              ),
                            );
                          }
                        },
                        builder: (BuildContext context, AuthState state) {
                          return CustomButton(
                            gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
                            text: AppStrings.loginButtonText.tr(),
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().loginUser(
                                    email: DataIntent.popEmail()!,
                                    password: DataIntent.popPassword()!);
                              }
                            },
                            isLoading: state is AuthLoading,
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
      ),
    );
  }
}
