// import 'package:alqaysar_rates/core/helper/extensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/resource/assets_manager.dart';
// import '../../../core/resource/colors_manager.dart';
// import 'custom_button.dart';
//
// class BottomSheetDesign extends StatelessWidget{
//   final String textBtn;
//
//   const BottomSheetDesign({
//     super.key,
//     required this.textBtn
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.6,
//       maxChildSize: 0.9,
//       minChildSize: 0.32,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return Container(
//           width: MediaQuery.of(context).size.width,//to take all width of screen
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: AppColors.primaryContainerColor,
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//           ),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(10.0),
//                     child: Image.asset(
//                       ImageAssets.person,
//                       width: 200.w,
//                       height: 200.h,
//                     ),
//                   ),
//                   SizedBox(height: 55.h),
//                   Container(
//                     width: 380.w,
//                     height: 55.h,
//                     decoration: BoxDecoration(
//                       color: AppColors.secondaryContainerColor,
//                       borderRadius: BorderRadius.circular(16.r),
//                     ),
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: const TextStyle(color: Colors.black),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15.r),
//                           borderSide: const BorderSide(color: AppColors.enableBorderColor),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(vertical: 40.h).copyWith(left: 15.w),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 80.h),
//                   // Button with Gradient
//                   Container(
//                     width: 300.w,
//                     height: 50.h,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: AppColors.primaryContainerColor,
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(25.r),
//                     ),
//                     child: CustomButton(
//                       colorOfBorder: AppColors.successColor,
//                       text: textBtn,
//                       onPressed: () {
//                         context.pop();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// }