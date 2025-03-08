import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/helper/language/language_helper.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/routes/route_constants.dart';
import '../../../../../core/resource/assets_manager.dart';
import '../../../../../core/resource/colors_manager.dart';

class HomeScreenAppBarWidget extends StatelessWidget{

  final int branch;
  const HomeScreenAppBarWidget({super.key,required this.branch});
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
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 40, top: 35, bottom: 10, right: 20),
                child: Image.asset(
                  ImageAssets.languageIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              onTap: (){
                AppLanguages.toggleLocal(context);
              }
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 50, top: 35, bottom: 10, right: 65),
              child: Text(
                AppStrings.appName.tr(),
                textDirection: AppLanguages.getCurrentTextDirection(context),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                   ),
              ),
            ),
            const Spacer(), // to handle spaces between appBar elements
            Container(
              margin: const EdgeInsets.only(
                top: 35, bottom: 10,),
              child: IconButton(
                icon: const Icon(Icons.search,color: Colors.white),
                onPressed: () {
                  context.pushNamed(Routes.searchScreenRoute,arguments: branch);
                },
              ),
            ),
          ],
        ),
      );
  }

}