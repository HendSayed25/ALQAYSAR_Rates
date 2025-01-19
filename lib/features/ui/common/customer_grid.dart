import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/config/routes/route_constants.dart';
import '../../../service_locator.dart';
import '../../data/local/app_prefs.dart';
import '../../domain/entities/customer.dart';
import 'user_card_design.dart';

class CustomerGrid extends StatelessWidget {
  final List<Customer> customers;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const CustomerGrid({
    super.key,
    required this.customers,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 33,
    this.mainAxisSpacing = 33,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      // some slivers
      SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(13.w),
            child: LayoutGrid(
                    columnSizes: crossAxisCount == 2 ? [1.fr, 1.fr] : [1.fr],
                    rowSizes: List.generate(
            (customers.length / crossAxisCount).ceil(),
            (_) => auto,
                    ),
                    rowGap: 40,
                    columnGap: 24,
                    children: [
            ...customers.map((customer) {
              return SizedBox(
                width: 190.w,
                height: 235.h,
                child: GestureDetector(
                onTap:(){context.pushNamed(Routes.userOverviewScreenRoute);},
                  child: UserCard(
                    userName: customer.name,
                    showRating: sl<AppPrefs>().getString("role") == "admin",
                    rating: double.parse(customer.rating.toStringAsFixed(1)),
                  ),
                ),
              );
            }),
                    ],
                  ),
          ))
    ]);
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../service_locator.dart';
// import '../../data/local/app_prefs.dart';
// import '../../domain/entities/customer.dart';
// import 'user_card_design.dart';
//
// class CustomerGrid extends StatelessWidget {
//   final List<Customer> customers;
//   final int crossAxisCount;
//   final double crossAxisSpacing;
//   final double mainAxisSpacing;
//
//   const CustomerGrid({
//     super.key,
//     required this.customers,
//     this.crossAxisCount = 2,
//     this.crossAxisSpacing = 33,
//     this.mainAxisSpacing = 33,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
//     final double itemWidth = size.width / 2;
//
//     return GridView.builder(
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: crossAxisSpacing.w,
//         mainAxisSpacing: mainAxisSpacing.h,
//         childAspectRatio: (itemWidth / itemHeight),
//       ),
//       itemCount: customers.length,
//       itemBuilder: (context, index) {
//         final customer = customers[index];
//         return UserCard(
//           userName: customer.name,
//           showRating: sl<AppPrefs>().getString("role") == "admin",
//           rating: customer.rating.floorToDouble(),
//         );
//       },
//     );
//   }
// }
