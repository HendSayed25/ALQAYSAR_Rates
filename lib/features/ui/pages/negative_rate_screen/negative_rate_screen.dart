import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../common/comment_item_design.dart';

class NegativeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.backgroundColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CommentItemDesign(
                    phone: "01279336697",
                    comment: "good",
                    imagePath: ImageAssets.emojySad,
                    screenType:"negative",
                    customerName: "Mohamed Ahmed",
                );
              })),
    );
  }
}
