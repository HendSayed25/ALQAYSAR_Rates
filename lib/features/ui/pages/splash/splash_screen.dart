// import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
// import 'package:alqaysar_rates/core/helper/extensions.dart';
// import 'package:alqaysar_rates/core/resource/colors_manager.dart';
// import 'package:alqaysar_rates/core/resource/strings.dart';
// import 'package:alqaysar_rates/features/data/local/app_prefs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../service_locator.dart';
// import 'widgets/image_animation.dart';
// import 'widgets/text_animation.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _imageController;
//   late AnimationController _textController;
//   late Animation<Offset> _imageAnimation;
//   late Animation<double> _text1Opacity;
//   late Animation<double> _text2Opacity;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//   }
//
//   void _initializeAnimations() {
//     _imageController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _imageAnimation = Tween<Offset>(
//       begin: const Offset(0.5, 0),
//       end: Offset.zero,
//     ).animate(
//         CurvedAnimation(parent: _imageController, curve: Curves.easeInOut));
//
//     _textController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     _text1Opacity = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _textController, curve: const Interval(0.2, 0.5)),
//     );
//     _text2Opacity = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _textController, curve: const Interval(0.5, 0.8)),
//     );
//
//     _imageController.forward();
//
//     Future.delayed(const Duration(milliseconds: 1250), () {
//       _textController.forward();
//     });
//
//     // After the animation finishes, navigate to the LoginScreen
//     Future.delayed(const Duration(milliseconds: 2300), () {
//       int? selectedBranch = (sl<AppPrefs>().getInt("branch")!=null)?sl<AppPrefs>().getInt("branch"):0;
//
//       if (sl<AppPrefs>().getBool("remember") == true) {
//         if (sl<AppPrefs>().getString("role") == "admin") {
//           context.pushReplacementNamed(Routes.homeScreenAdminRoute);
//         } else {
//           if (selectedBranch != 0) {
//              if(selectedBranch==1){
//                context.pushReplacementNamed(Routes.showAllRoute,arguments:1);
//              }else{
//                context.pushReplacementNamed(Routes.showAllRoute,arguments:2);
//              }
//           } else{
//             context.pushReplacementNamed(Routes.selectionScreen,arguments: {Routes.showAllRoute,"user"});
//           }
//         }
//       } else {
//         context.pushReplacementNamed(Routes.loginScreenRoute);
//       }
//
//       // sl<AppPrefs>().getBool("remember") == true
//       //     ? sl<AppPrefs>().getString("role") == "admin"
//       //         ? context.pushReplacementNamed(Routes.homeScreenAdminRoute)
//       //         : context.pushReplacementNamed(Routes.showAllRoute)
//       //     : context.pushReplacementNamed(Routes.loginScreenRoute);
//       // //context.pushReplacementNamed(Routes.loginScreenRoute);
//     });
//   }
//
//   @override
//   void dispose() {
//     _imageController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: AppColors.backgroundColor,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Stack(
//             children: [
//               ImageAnimation(imageAnimation: _imageAnimation),
//               Positioned(
//                 right: 55.w,
//                 top: 0.5.sh - 40.h,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     TextAnimation(
//                       text1Opacity: _text1Opacity,
//                       text: 'القيصر',
//                       textSize: 48,
//                     ),
//                     TextAnimation(
//                       text1Opacity: _text2Opacity,
//                       text: AppStrings.appName,
//                       textSize: 24.sp,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:alqaysar_rates/features/data/local/app_prefs.dart';
import 'package:alqaysar_rates/features/ui/pages/splash/widgets/image_animation.dart';
import 'package:alqaysar_rates/features/ui/pages/splash/widgets/text_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:logger/logger.dart';

import '../../../../service_locator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2500), () {
      int? selectedBranch = (sl<AppPrefs>().getInt("branch") ?? 0);
      Logger().i("${sl<AppPrefs>().getBool("remember")} ${sl<AppPrefs>().getString("role")}");
      if (sl<AppPrefs>().getBool("remember") == true) {
        if (sl<AppPrefs>().getString("role") == "admin") {
          context.pushReplacementNamed(Routes.homeScreenAdminRoute);
        } else {
          if (selectedBranch != 0) {
            context.pushReplacementNamed(Routes.showAllRoute, arguments: selectedBranch);
          } else {
            context.pushReplacementNamed(Routes.selectionScreen, arguments: {Routes.showAllRoute, "user"});
          }
        }
      } else {
        context.pushReplacementNamed(Routes.loginScreenRoute);
      }
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox.expand(
          child: Stack(
            children: [
              Center(child: ImageAnimation()),
              Positioned(
                right: 55.w,
                top: 0.5.sh - 40.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextAnimation(
                      text: 'القيصر',
                      textSize: 48,
                      delay: 1500.ms,
                    ),
                    TextAnimation(
                      text: AppStrings.appName,
                      textSize: 24.sp,
                      delay: 2000.ms,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
