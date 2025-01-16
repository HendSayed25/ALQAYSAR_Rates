import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/strings.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.primaryContainerColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: AppStrings.search, // Use constant for text
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: onSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}