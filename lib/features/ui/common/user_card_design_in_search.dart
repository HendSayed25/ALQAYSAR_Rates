import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resource/assets_manager.dart';

class UserCardInSearch extends StatelessWidget {
  final String userName;
  final double rating;
  final bool showRating;

  const UserCardInSearch({
    super.key,
    required this.userName,
    required this.showRating,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
     return Center(
       child:  Center(
         child: Container(
           margin: const EdgeInsets.only(top:25.0,left: 18,right: 18),
           padding: const EdgeInsets.all(15.0),
           decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryContainerColor,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38),
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),

           ),
           child: Row(
             children: [
               Image.asset(
                   ImageAssets.person,
                   width: 180.w,
                   height: 160.h,
                 ),
               SizedBox(width: 16.0.w),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     userName,
                     style: TextStyle(
                       fontSize: 20.sp,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   SizedBox(height: 15.h),
                   if (showRating) ...[
                     Row(
                       children: [
                         Text(
                           "$rating / 5",
                           style: TextStyle(fontSize: 17.sp),
                         ),
                         SizedBox(width: 5.w),
                         const Icon(Icons.star,
                             color: Colors.amber, size: 16),
                       ],
                     ),
                   ],
                 ],
               ),
             ],
           ),
         ),
       ),
     );
  }
}
