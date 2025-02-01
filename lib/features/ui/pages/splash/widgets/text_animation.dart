import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/language/language_helper.dart';

class TextAnimation extends StatelessWidget {
  const TextAnimation({
    super.key,
    required Animation<double> text1Opacity,
    required String text,
    required double textSize,
  })  : _text1Opacity = text1Opacity,
        _text = text,
        _textSize = textSize;

  final Animation<double> _text1Opacity;
  final String _text;
  final double _textSize;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _text1Opacity,
      child: Text(
        _text,
        style: TextStyle(
          fontSize: _textSize.sp,
          fontWeight: FontWeight.bold,
        ),
        textDirection: AppLanguages.getCurrentTextDirection(context),
      ),
    );
  }
}
