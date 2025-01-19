import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resource/strings.dart';

class EmojyDesignWidget extends StatefulWidget {
  const EmojyDesignWidget({super.key});

  @override
  _EmojyDesignWidgetState createState() => _EmojyDesignWidgetState();
}

class _EmojyDesignWidgetState extends State<EmojyDesignWidget> {
  final List<Map<String, String>> emojis = [
    {'emoji': '😍', 'title': AppStrings.excellent.tr()},
    {'emoji': '😊', 'title': AppStrings.veryGood.tr()},
    {'emoji': '🙂', 'title': AppStrings.good.tr()},
    {'emoji': '😟', 'title': AppStrings.weak.tr()},
    {'emoji': '😡', 'title': AppStrings.bad.tr()},
  ];

  int? selectedEmojiIndex;

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(emojis.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedEmojiIndex = index;
                  });
                },
                child:
                   Column(
                    children: [
                      Text(
                        emojis[index]['emoji']!,
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: selectedEmojiIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        emojis[index]['title']!,
                        style: TextStyle(
                          fontWeight: selectedEmojiIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedEmojiIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),

              );
            }),
          ),
          const SizedBox(height: 30),

        ],
    );
  }
}

