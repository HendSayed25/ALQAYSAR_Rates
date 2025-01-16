import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../common/user_card_design.dart';

class ShowAllForAdminScreen extends StatefulWidget {
  const ShowAllForAdminScreen({super.key});

  @override
  State<ShowAllForAdminScreen> createState()=>_ShowAllForAdminScreenState();
}
class _ShowAllForAdminScreenState extends State<ShowAllForAdminScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
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
                  margin: const EdgeInsets.only(left:40,top: 70,bottom: 10,right: 20),
                  child: Image.asset(ImageAssets.languageIcon,
                    width: 30.w,
                    height: 30.h,),
                ),
                Container(
                  margin: const EdgeInsets.only(left:50,top: 70,bottom: 10,right: 30),
                  child: const Text("ALQAYSAR"
                    ,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.only(left:40,top: 70,bottom: 10,right: 10),
                  child: Image.asset(ImageAssets.searchIcon,
                    width: 25.w,
                    height: 25.h,),
                ),

              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const UserCard(
                      userName: "userName",showRating: true, rating:15,);
                  },
                ),
              ),
            ),


            // Padding(
            // padding: const EdgeInsets.all(16.0),
            // child: Container(
            //   padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
            //   margin: const EdgeInsets.only(left: 5,right: 5),
            //   decoration: BoxDecoration(
            //      color: AppColors.secondaryContainerColor,
            //       borderRadius: BorderRadius.circular(25),
            //   ),
            //     child:  Row(
            //       children: [
            //         const Icon(Icons.search, color: Colors.grey),
            //         SizedBox(width: 8.w),
            //         const Expanded(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 hintText: "Search",
            //                 hintStyle: TextStyle(color: Colors.grey),
            //                 border: InputBorder.none,
            //               ),
            //             ),
            //           ),
            //     ]),
            //   ),
            // ),
          ],),
      ),
    );
  }

}