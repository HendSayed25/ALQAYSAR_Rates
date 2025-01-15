import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/colors_manager.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState()=>_HomeUserScreenState();
}
class _HomeUserScreenState extends State<HomeUserScreen>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [
               AppColors.backgroundColor[0], // Start color
               AppColors.backgroundColor[1], // End color
             ],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
           ),
         ),
         child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Container(
                     margin: const EdgeInsets.only(left:40,top: 50,bottom: 10,right: 20),
                     child: Image.asset('assets/images/language_icon.png',
                     width: 30.w,
                     height: 30.h,),
                   ),
                   Container(
                       margin: const EdgeInsets.only(left:50,top: 50,bottom: 10,right: 20),
                       child: const Text("ALQAYSAR"
                       ,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                   ),
                 ],
               ),
             Padding(
             padding: const EdgeInsets.all(16.0),
             child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
               margin: const EdgeInsets.only(left: 5,right: 5),
               decoration: BoxDecoration(
                  color: AppColors.secondaryContainerColor,
                   borderRadius: BorderRadius.circular(25),
               ),
                 child: const Row(
                   children: [
                     Icon(Icons.search, color: Colors.grey),
                     SizedBox(width: 8),
                     Expanded(
                         child: TextField(
                           decoration: InputDecoration(
                             hintText: "Search",
                             hintStyle: TextStyle(color: Colors.grey),
                             border: InputBorder.none,
                           ),
                         ),
                       ),
                 ]),
               ),
             ),
         ],),
       ),
   );
  }

}