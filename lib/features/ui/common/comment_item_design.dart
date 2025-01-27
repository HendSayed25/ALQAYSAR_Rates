import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItemDesign extends StatelessWidget {
  final String phone;
  final String comment;
  final String imagePath;
  final String screenType;
  final String customerName;
  final String rate;

  const CommentItemDesign({
    super.key,
    required this.phone,
    required this.comment,
    required this.imagePath,
    required this.screenType,
    required this.customerName,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 10.0.w),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 25.0.h, left: 18.w, right: 18.w),
          padding: EdgeInsets.all(15.0.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.primaryContainerColor),
            borderRadius: BorderRadius.circular(33.r),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPhoneAndCustomerName(),
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
              _buildCommentContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneAndCustomerName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.Phone.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              phone,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (screenType == "negative")
          Text(
            customerName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  Widget _buildCommentContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(5.r),
          width: 300.w,
          height: 150.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.backgroundColor),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Text(
              comment.isEmpty ? AppStrings.noComment.tr() : comment,
              maxLines: 5,
            ),
          ),
        ),
      ],
    );
  }
}


class InteractiveImage extends StatefulWidget {
  final String imagePath;
  final String rate;

  const InteractiveImage({
    super.key,
    required this.imagePath,
    required this.rate,
  });

  @override
  _InteractiveImageState createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<InteractiveImage> {
  bool _showText = false;

  void _toggleImageText() {
    setState(() {
      _showText = !_showText;
    });

    if (_showText) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _showText = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleImageText,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _showText
            ? Text(
          widget.rate,
          key: const ValueKey(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        )
            : Image.asset(
          widget.imagePath,
          key: const ValueKey(2),
          width: 45.w,
          height: 45.h,
        ),
      ),
    );
  }
}
