import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/routes/route_constants.dart';
import '../../../../../core/resource/assets_manager.dart';
import '../../../../../core/resource/colors_manager.dart';

class HomeScreenAppBarWidget extends StatelessWidget{

  const HomeScreenAppBarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 40, top: 35, bottom: 10, right: 20),
              child: Image.asset(
                ImageAssets.languageIcon,
                width: 30.w,
                height: 30.h,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 50, top: 35, bottom: 10, right: 30),
              child: const Text(
                "ALQAYSAR",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(), // to handle spaces between appBar elements
            Container(
              margin: const EdgeInsets.only(
                top: 35, bottom: 10,),
              child: IconButton(
                icon: const Icon(Icons.search,color: Colors.white),
                onPressed: () {
                  context.pushNamed(Routes.searchScreenRoute);
                },
              ),
            ),
          ],
        ),
      );
  }

}