import 'package:flutter/material.dart';
// import 'package:quizer/core/resources/app_colors.dart';

extension Navigation on BuildContext {
  pop() => Navigator.of(this).pop();

  pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}

// extension MediaQueryValues on BuildContext {
//   double get width => MediaQuery.of(this).size.width;
//
//   double get height => MediaQuery.of(this).size.height;
//
//   double get topPadding => MediaQuery.of(this).viewPadding.top;
//
//   double get bottom => MediaQuery.of(this).viewInsets.bottom;
// }
//
// extension SnakBar on BuildContext {
//   void message({
//     required String message,
//     Color? color,
//     Color? textColor,
//     Duration? duration,
//   }) =>
//       ScaffoldMessenger.of(this).showSnackBar(
//         SnackBar(
//           behavior: SnackBarBehavior.floating,
//           content: Text(
//             message,
//             style: TextStyle(color: textColor ?? AppColors.whiteColor),
//           ),
//           backgroundColor: color ?? AppColors.blackColor,
//           duration: duration ?? const Duration(seconds: 2),
//         ),
//       );
// }
//
// extension ColorTheme on BuildContext {
//   Color get primaryColor => Theme.of(this).primaryColor;
//
//   Color get darkPrimaryColor => Theme.of(this).primaryColorDark;
//
//   Color get primaryColorScheme => Theme.of(this).colorScheme.primary;
//
//   Color get secondaryColorScheme => Theme.of(this).colorScheme.secondary;
//
//   Color get tertiaryColorScheme => Theme.of(this).colorScheme.tertiary;
// }
//
// extension StringExtension on String? {
//   RegExp get isContainsLink {
//     return RegExp(
//       r'((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?([a-z0-9]+([-\.]{1}[a-z0-9]+)*\.[a-z]{2,5})(:[0-9]{1,5})?(\/\S*)?)',
//       caseSensitive: false,
//       multiLine: true,
//     );
//   }
//
//   bool isNullOrEmpty() => this == null || this!.isEmpty || this == '';
// }
