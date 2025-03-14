
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/resource/strings.dart';
import 'dart:ui' as ui;


class PhoneAndCustomerName extends StatelessWidget {
  final String phone;
  final String customerName;
  final String screenType;

  const PhoneAndCustomerName({
    super.key,
    required this.phone,
    required this.customerName,
    required this.screenType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.Phone.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Text(
                phone,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ).animate().slideX(),
        if (screenType == "negative")
          Text(
            customerName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ).animate().fade(duration: 300.ms),
      ],
    );
  }
}
