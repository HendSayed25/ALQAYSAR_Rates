import 'package:alqaysar_rates/core/resource/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../../core/resource/strings.dart';

class EmojiDesignWidget extends StatefulWidget {
  final Function(String)? onEmojiSelected;

  const EmojiDesignWidget({super.key, this.onEmojiSelected});

  @override
  _EmojiDesignWidgetState createState() => _EmojiDesignWidgetState();
}

class _EmojiDesignWidgetState extends State<EmojiDesignWidget> {
  final List<Map<String, dynamic>> emojis = [
    {
      'emoji': ImageAssets.emojiBad,
      'title': AppStrings.bad.tr(),
      'category': 'uncooperative'
    },
    {
      'emoji': ImageAssets.emojiWeek,
      'title': AppStrings.weak.tr(),
      'category': 'poor'
    },
    {
      'emoji': ImageAssets.emojiGood,
      'title': AppStrings.good.tr(),
      'category': 'good'
    },
    {
      'emoji': ImageAssets.emojiVeryGood,
      'title': AppStrings.veryGood.tr(),
      'category': 'veryGood'
    },
    {
      'emoji': ImageAssets.emojiExcellent,
      'title': AppStrings.excellent.tr(),
      'category': 'excellent'
    },
  ];

  int? selectedEmojiIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: emojis.asMap().entries.map((entry) {
            final index = entry.key;
            final emoji = entry.value['emoji'];
            final title = entry.value['title'];

            return _buildEmojiItem(index, emoji, title);
          }).toList(),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _buildEmojiItem(int index, String emoji, String title) {
    final isSelected = selectedEmojiIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmojiIndex = index;
        });
        if (widget.onEmojiSelected != null) {
          widget.onEmojiSelected!(emojis[index]['category']);
        }
        Logger().i('emoji $emoji');
      },
      child: Column(
        children: [
          Image.asset(
            emoji,
            width: 40.w,
            height: 40.w,
            color: isSelected ? Colors.white : Colors.black,
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
