import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/customer.dart';
import 'user_card_design.dart';

class CustomerGrid extends StatelessWidget {
  final List<Customer> customers;

  const CustomerGrid({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
        ),
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return UserCard(
            userName: customer.name,
            showRating: true,
            rating: customer.rating.floorToDouble(),
          );
        },
      ),
    );
  }
}