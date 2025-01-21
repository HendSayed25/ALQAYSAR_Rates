import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/user_card_design.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.userOverviewScreenRoute);
                  },
                  child: const UserCard(
                    userName: "userName",
                    showRating: false,
                    rating: 0,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
