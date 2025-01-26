import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:alqaysar_rates/features/ui/common/comment_item_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/colors_manager.dart';

class CommentsScreen extends StatelessWidget {
  final String customerName;
  const CommentsScreen({
    Key? key, required this.customerName
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.backgroundColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 55.0),
                child: Text(
                  customerName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18.sp),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 70,
              endIndent: 70,
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CommentItemDesign(
                        phone: "01279336697",
                        comment: "good",
                        imagePath: ImageAssets.emojiBad,
                        screenType: "comment",
                        customerName: "",
                    );
                  }),
            )
          ],
        ),
      ),
    ));

  }
}
