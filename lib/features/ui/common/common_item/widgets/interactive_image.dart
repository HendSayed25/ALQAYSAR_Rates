
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteractiveImage extends StatefulWidget {
  final String imagePath;
  final String rate;

  const InteractiveImage({
    super.key,
    required this.imagePath,
    required this.rate,
  });

  @override
  _InteractiveImageState createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<InteractiveImage> {
  bool _showText = false;

  void _toggleImageText() {
    setState(() {
      _showText = !_showText;
    });

    if (_showText) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showText = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleImageText,
      child: _showText
          ? Text(
        widget.rate,
        key: const ValueKey(1),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: Colors.black,
        ),
      ).animate().fade(duration: 300.ms).scale()
          : Image.asset(
        widget.imagePath,
        key: const ValueKey(2),
        width: 45.w,
        height: 45.h,
      ).animate().fade(duration: 500.ms).scale(),
    );
  }
}
