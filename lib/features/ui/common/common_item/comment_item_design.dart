import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/resource/strings.dart';
import 'widgets/comment.dart';
import 'widgets/interactive_image.dart';
import 'widgets/phone_customer_name.dart';

class CommentItemDesign extends StatelessWidget {
  final String phone;
  final String comment;
  final String imagePath;
  final String screenType;
  final String customerName;
  final String rate;
  final DateTime? timestamp;

  const CommentItemDesign({
    super.key,
    required this.phone,
    required this.comment,
    required this.imagePath,
    required this.screenType,
    required this.customerName,
    required this.rate,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 350.w,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 25.h, left: 18.w, right: 18.w),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.primaryContainerColor),
              borderRadius: BorderRadius.circular(33.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PhoneAndCustomerName(
                        phone: phone,
                        customerName: customerName,
                        screenType: screenType,
                      ),
                      InteractiveImage(
                        imagePath: imagePath,
                        rate: rate,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 2.w,
                  endIndent: 2.w,
                ),
                CommentContainer(
                  comment: comment,
                ),
                Text(
                  timestamp != null
                      ? DateFormat('yyyy/MM/dd  hh:mm:ss a', 'ar_SA').format(timestamp!.add(Duration(hours: 3)))
                      : AppStrings.noDate.tr(),
                  style: TextStyle(fontSize: 20.sp),
                ),
              ],
            ).animate().fade(duration: 500.ms).scale(),
          ),
        ),
      ),
    );
  }
}
