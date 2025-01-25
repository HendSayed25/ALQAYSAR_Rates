// import 'package:easy_localization/easy_localization.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/resource/strings.dart';
// import 'indecator.dart';
//
// class PieChartSample2 extends StatefulWidget {
//   final List<double> values;
//   final List<Color> colors;
//
//   const PieChartSample2({
//     super.key,
//     required this.values,
//     required this.colors,
//   });
//
//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }
//
// class PieChart2State extends State<PieChartSample2> {
//   int touchedIndex = -1;
//   List<String> rating = [
//     AppStrings.excellent.tr(),
//     AppStrings.veryGood.tr(),
//     AppStrings.good.tr(),
//     AppStrings.weak.tr(),
//     AppStrings.bad.tr()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: PieChart(
//             PieChartData(
//               pieTouchData: PieTouchData(
//                 touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                   setState(() {
//                     if (!event.isInterestedForInteractions ||
//                         pieTouchResponse == null ||
//                         pieTouchResponse.touchedSection == null) {
//                       touchedIndex = -1;
//                       return;
//                     }
//                     touchedIndex =
//                         pieTouchResponse.touchedSection!.touchedSectionIndex;
//                   });
//                 },
//               ),
//               borderData: FlBorderData(
//                 show: false,
//               ),
//               sectionsSpace: 4,
//               centerSpaceRadius: 36,
//               sections: showingSections(),
//             ),
//           ),
//         ),
//         SizedBox(width: 26.w),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Indicator(
//               color: widget.colors[0],
//               text: rating[0],
//               isSquare: true,
//             ),
//             SizedBox(height: 8.h),
//             Indicator(
//               color: widget.colors[1],
//               text: rating[1],
//               isSquare: true,
//             ),
//             SizedBox(height: 8.h),
//             Indicator(
//               color: widget.colors[2],
//               text: rating[2],
//               isSquare: true,
//             ),
//             SizedBox(height: 8.h),
//             Indicator(
//               color: widget.colors[3],
//               text: rating[3],
//               isSquare: true,
//             ),
//             SizedBox(height: 8.h),
//             Indicator(
//               color: widget.colors[4],
//               text: rating[4],
//               isSquare: true,
//             ),
//             SizedBox(height: 18.h),
//           ],
//         ),
//       ],
//     );
//   }
//
//   List<PieChartSectionData> showingSections() {
//     return List.generate(widget.values.length, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0.sp : 16.0.sp;
//       final radius = isTouched ? 60.0.r : 50.0.r;
//       final shadows = [Shadow(color: Colors.black, blurRadius: 2.r)];
//
//       return PieChartSectionData(
//         color: widget.colors[i],
//         value: widget.values[i],
//         title: '${widget.values[i].toStringAsFixed(1)}%',
//         radius: radius,
//         titleStyle: TextStyle(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//           shadows: shadows,
//         ),
//       );
//     });
//   }
// }
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/ui/pages/comments_screen/comments_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/routes/route_constants.dart';

class RatingChart extends StatelessWidget {

  List<String> rating = [
    AppStrings.excellent.tr(),
    AppStrings.veryGood.tr(),
    AppStrings.good.tr(),
    AppStrings.weak.tr(),
    AppStrings.bad.tr()
  ];
  List<double>values;
  final String customerName;

  RatingChart({
    super.key,
    required this.values,
    required this.customerName
});

  @override
  Widget build(BuildContext context) {
    return  Center(
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
                   onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CommentsScreen(customerName: customerName))),
                   child: Image.asset(
                     ImageAssets.commentIcon,
                     width: 25.w,
                     height: 25.h,),
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
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {//value of rate
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                values[value.toInt()].toStringAsFixed(1), // Show the actual value (percentage)
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

  BarChartGroupData _buildBar(int x, double value) {//second parameter the value of rate (will change from database)
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
