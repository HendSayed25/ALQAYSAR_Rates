import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/strings.dart';

class CommentContainer extends StatelessWidget {
  final String comment;

  const CommentContainer({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120.h,
        maxHeight: 160.h,
      ),
      margin: EdgeInsets.all(5.r),
      width: 300.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: AppColors.backgroundColor),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: SingleChildScrollView(
          child: Text(
            comment.isEmpty ? AppStrings.noComment.tr() : comment,
            style: TextStyle(fontSize: 14.sp),
          ).animate().fade(duration: 500.ms).scale(),
        ),
      ),
    );
  }
}
