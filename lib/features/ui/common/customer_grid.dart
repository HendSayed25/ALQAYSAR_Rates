import 'package:alqaysar_rates/core/helper/data_intent.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/config/routes/route_constants.dart';
import '../../../service_locator.dart';
import '../../data/local/app_prefs.dart';
import '../../domain/entities/customer_entity.dart';
import 'user_card_design.dart';

class CustomerGrid extends StatelessWidget {
  final List<CustomerEntity> customers;
  final double? averageRate;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const CustomerGrid({
    super.key,
    required this.customers,
    required this.averageRate,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 33,
    this.mainAxisSpacing = 33,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 25.h, left: 15.w, right: 15.w),
          child: LayoutGrid(
            columnSizes: crossAxisCount == 2 ? [1.fr, 1.fr] : [1.fr],
            rowSizes: List.generate(
              (customers.length / crossAxisCount).ceil(),
              (_) => auto,
            ),
            rowGap: 24,
            columnGap: 24,
            children: [
              ...customers.map((customer) {
                return SizedBox(
                  width: 190.w,
                  height: 235.h,
                  child: GestureDetector(
                    onTap: () {
                      DataIntent.pushCustomer(customer);
                      sl<AppPrefs>().getString("role") == "admin"
                          ? context.pushNamed(Routes.userOverviewScreenRoute)
                          : context.pushNamed(Routes.rateScreenUserRoute);
                    },
                    child: UserCard(
                      userName: customer.name,
                      showRating: sl<AppPrefs>().getString("role") == "admin",
                      // rating: double.parse(customer.rating.toStringAsFixed(1)),
                      rating: averageRate ?? 5,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    ]);
  }
}
