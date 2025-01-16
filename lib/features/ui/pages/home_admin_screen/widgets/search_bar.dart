import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/features/ui/pages/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/routes/route_constants.dart';
import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/strings.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  SearchBarWidget({super.key, required this.onSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.pushNamed(Routes.searchScreenRoute);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: AppStrings.search, // Use constant for text
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: widget.onSearch,

              ),
            ),
          ],
        ),
      ),
    );
  }
}