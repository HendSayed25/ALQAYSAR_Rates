import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/strings.dart';
import 'indecator.dart';

class PieChartSample2 extends StatefulWidget {
  final List<double> values;
  final List<Color> colors;

  const PieChartSample2({
    super.key,
    required this.values,
    required this.colors,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  List<String> rating = [
    AppStrings.excellent.tr(),
    AppStrings.veryGood.tr(),
    AppStrings.good.tr(),
    AppStrings.weak.tr(),
    AppStrings.bad.tr()
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 4,
              centerSpaceRadius: 36,
              sections: showingSections(),
            ),
          ),
        ),
        SizedBox(width: 26.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Indicator(
              color: widget.colors[0],
              text: rating[0],
              isSquare: true,
            ),
            SizedBox(height: 8.h),
            Indicator(
              color: widget.colors[1],
              text: rating[1],
              isSquare: true,
            ),
            SizedBox(height: 8.h),
            Indicator(
              color: widget.colors[2],
              text: rating[2],
              isSquare: true,
            ),
            SizedBox(height: 8.h),
            Indicator(
              color: widget.colors[3],
              text: rating[3],
              isSquare: true,
            ),
            SizedBox(height: 8.h),
            Indicator(
              color: widget.colors[4],
              text: rating[4],
              isSquare: true,
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.values.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0.sp : 16.0.sp;
      final radius = isTouched ? 60.0.r : 50.0.r;
      final shadows = [Shadow(color: Colors.black, blurRadius: 2.r)];

      return PieChartSectionData(
        color: widget.colors[i],
        value: widget.values[i],
        title: '${widget.values[i].toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
