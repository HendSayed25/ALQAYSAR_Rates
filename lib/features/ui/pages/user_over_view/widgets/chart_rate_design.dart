import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/assets_manager.dart';
import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/strings.dart';

class RatingChart extends StatelessWidget {
  final List<String> rating = [
    AppStrings.excellent.tr(),
    AppStrings.veryGood.tr(),
    AppStrings.good.tr(),
    AppStrings.weak.tr(),
    AppStrings.bad.tr()
  ];
  final List<double> values;
  final String customerName;
  final int customerId;

  RatingChart(
      {super.key,
      required this.values,
      required this.customerName,
      required this.customerId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 340.w,
        height: 280.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.r,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.rateAnalytics.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => context.pushNamed(Routes.commentScreen,
                      arguments: {
                        "customerName": customerName,
                        "customerId": customerId
                      }),

                  child: Image.asset(
                    ImageAssets.commentIcon,
                    width: 25.w,
                    height: 25.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  groupsSpace: 45.0,
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          //value of rate
                          return Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Text(
                              values[value.toInt()].toStringAsFixed(1),
                              // Show the actual value (percentage)
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              rating[value.toInt()],
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  barGroups: [
                    _buildBar(0, values[0]),
                    _buildBar(1, values[1]),
                    _buildBar(2, values[2]),
                    _buildBar(3, values[3]),
                    _buildBar(4, values[4]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double value) {
    //second parameter the value of rate (will change from database)
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 15.w,
          gradient: LinearGradient(colors: AppColors.backgroundColor),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ],
    );
  }
}
