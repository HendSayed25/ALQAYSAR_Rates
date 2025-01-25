import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItemDesign extends StatelessWidget {
  final String phone;
  final String comment;
  final String imagePath;
  final String screenType;
  final String customerName;


  const CommentItemDesign({
    super.key,
    required this.phone,
    required this.comment,
    required this.imagePath,
    required this.screenType,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 25.0.h, left: 18.w, right: 18.w),
          padding: EdgeInsets.all(15.0.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryContainerColor,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(33.r),
              bottomRight: Radius.circular(33.r),
              topLeft: Radius.circular(33.r),
              topRight: Radius.circular(33.r),
            ),
          ),
          child:Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Phone: ",
                    style:TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Text(phone, style:TextStyle(fontWeight: FontWeight.bold),),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        imagePath,
                    width: 40.w,
                    height: 40.h,),
                  ),
                ],
              ),
              if(screenType=="negative")
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(customerName,
                        style:TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              Divider(
                color: Colors.black,
                thickness: 1,
                indent: 2,
                endIndent: 2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                      width: 300.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: AppColors.backgroundColor),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        comment,
                         maxLines: 5,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
