import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/features/ui/common/bottom_sheet_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/routes/route_constants.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../common/custom_button.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hi Admin",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 95.h,
                  ),
                  Container(
                    child: Center(
                        child: Image.asset(
                      ImageAssets.logo,
                      width: 200.w,
                      height: 200.h,
                    )),
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 1),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryContainerColor,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(children: [
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

                  SizedBox(height: 107.h),
                  Container(
                      width: 300.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: AppColors.primaryContainerColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: CustomButton(
                        colorOfBorder: Colors.transparent,
                          text: 'Show All',
                          onPressed: () {
                            context.pushNamed(Routes.showAllForAdminRoute);
                          })),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    colorOfBorder: AppColors.successColor,
                    text: 'Add',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.0),
                          ),
                        ),
                        builder: (context) {
                          return const BottomSheetDesign(textBtn: 'Add',);
                        },
                      );},
                  )
                  // Container(
                  //   width: 300.w,
                  //     height: 50.h,
                  //     alignment: Alignment.center,
                  //   margin: const EdgeInsets.only(left: 20,right: 20),
                  //
                  //   decoration: BoxDecoration(
                  //       gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.transparent,
                  //         shadowColor: Colors.transparent,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(25),
                  //         ),
                  //       ),
                  //       child: const Text(
                  //         "Add",
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




// SearchBar(
// backgroundColor: const WidgetStatePropertyAll(AppColors.secondaryContainerColor),
// elevation: const WidgetStatePropertyAll(4.0),
// shape: WidgetStatePropertyAll(
// RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(25.0)
// )
// ),
// padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.0.w)),
// onChanged: (query){
// //update UI
// },
// onTap: (){
// //when user tap
// },
// ),
