import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:alqaysar_rates/core/helper/extensions.dart';
import '../../../core/helper/language/language_helper.dart';
import '../../../core/resource/assets_manager.dart';
import '../../../core/resource/colors_manager.dart';
import '../../../core/resource/strings.dart';
import 'custom_button.dart';

class BottomSheetDesign extends StatefulWidget {
  final String textBtn;
  final bool? isLoading;
  final String? name;
  final int? branch;
  final Function(String, int) onPressed;

  const BottomSheetDesign({
    super.key,
    required this.textBtn,
    required this.onPressed,
    this.isLoading,
    this.name,
    this.branch,
  });

  @override
  State<BottomSheetDesign> createState() => _BottomSheetDesignState();
}

class _BottomSheetDesignState extends State<BottomSheetDesign> {
  late TextEditingController _nameController;
  String? selectedBranch;

  final List<String> branches = [
    AppStrings.firstBranch.tr(),
    AppStrings.secondBranch.tr()
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
    if (widget.branch != null) {
      selectedBranch = (widget.branch == 1)
          ? AppStrings.firstBranch.tr()
          : AppStrings.secondBranch.tr();
    }
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
                SizedBox(height: 30.h),

                InputField(
                  controller: _nameController,
                  labelText: AppStrings.name.tr(),
                  hintText: AppStrings.enterName.tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20.h),

                Container(
                  width: 380.w,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainerColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.enableBorderColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child:DropdownButton<String>(
                      value: selectedBranch,
                      dropdownColor: AppColors.secondaryContainerColor,
                      hint: Text(
                        AppStrings.chooseBranch.tr(),
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      items: branches.map((branch) {
                        return DropdownMenuItem<String>(
                          value: branch,
                          child: Text(
                            branch,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBranch = value;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                CustomButton(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryContainerColor,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  colorOfBorder: AppColors.successColor,
                  text: widget.textBtn.tr(),
                  isLoading: widget.isLoading ?? false,
                  onPressed: () {
                    if (_nameController.text.isEmpty || selectedBranch == null || selectedBranch!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content: Text(
                            AppStrings.nameRequiredAndBranch.tr(),
                            textDirection: AppLanguages.getCurrentTextDirection(context),
                          ),
                        ),
                      );
                    } else {
                      int branch = (selectedBranch == AppStrings.firstBranch.tr()) ? 1 : 2;
                      widget.onPressed(_nameController.text, branch);
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
        textDirection: AppLanguages.getCurrentTextDirection(context),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText.tr(),
          labelStyle: const TextStyle(color: Colors.black),
          hintText: hintText.tr(),
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: AppColors.enableBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h).copyWith(left: 20.w),
        ),
      ),
    );
  }
}
