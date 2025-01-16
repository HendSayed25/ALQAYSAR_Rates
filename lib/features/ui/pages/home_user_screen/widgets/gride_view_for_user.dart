import 'package:flutter/cupertino.dart';

import '../../../common/user_card_design.dart';

class GridViewWidget extends StatelessWidget{
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Container(
        //       margin: const EdgeInsets.only(
        //           left: 40, top: 70, bottom: 10, right: 20),
        //       child: Image.asset(
        //         ImageAssets.languageIcon,
        //         width: 30.w,
        //         height: 30.h,
        //       ),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.only(
        //           left: 50, top: 70, bottom: 10, right: 30),
        //       child: const Text(
        //         "ALQAYSAR",
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 25,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.only(
        //           left: 40, top: 70, bottom: 10, right: 10),
        //       child: Image.asset(
        //         ImageAssets.searchIcon,
        //         width: 25.w,
        //         height: 25.h,
        //       ),
        //     ),
        //   ],
        // ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                childAspectRatio: 0.9,

              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const UserCard(
                  userName: "userName",
                  showRating: false,
                  rating: 0,
                );
              },
            ),
          ),
        ),
      ],
    );
  }


}