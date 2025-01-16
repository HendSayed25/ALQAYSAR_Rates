import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/assets_manager.dart';
import '../../../core/resource/colors_manager.dart';
import '../../../core/resource/strings.dart';
import 'custom_button.dart';

class BottomSheetDesign extends StatefulWidget {
  final String textBtn;
  final bool? isLoading;
  final Function(String) onPressed;

  const BottomSheetDesign({
    super.key,
    required this.textBtn,
    required this.onPressed,
    this.isLoading,
  });

  @override
  State<BottomSheetDesign> createState() => _BottomSheetDesignState();
}

class _BottomSheetDesignState extends State<BottomSheetDesign> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.32,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    margin: EdgeInsets.all(10.w),
                    child: Image.asset(
                      ImageAssets.person,
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  SizedBox(height: 55.h),

                  InputField(
                    controller: _nameController,
                    labelText: AppStrings.name,
                    hintText: AppStrings.enterName,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 80.h),

                  CustomButton(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryContainerColor,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    colorOfBorder: AppColors.successColor,
                    text: widget.textBtn,
                    isLoading: widget.isLoading??false,
                    onPressed: () {
                      if (_nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.nameRequired),
                          ),
                        );
                      } else {
                        widget.onPressed(_nameController.text);
                        context.pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.secondaryContainerColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: AppColors.enableBorderColor),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 40.h).copyWith(left: 15.w),
        ),
      ),
    );
  }
}