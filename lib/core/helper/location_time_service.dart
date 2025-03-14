// import 'package:intl/intl.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:logger/logger.dart';
// import 'package:alqaysar_rates/service_locator.dart';
//
// import '../../features/data/local/app_prefs.dart';
//
// class LocationTimeService {
//   final Logger logger = Logger();
//   Future<String> getCurrentTimeZone() async {
//     try {
//       String timeZone = await FlutterNativeTimezone.getLocalTimezone();
//       return timeZone;
//     } catch (e) {
//       print("Error getting time zone: $e");
//       return "UTC";
//     }
//   }
//
//   String formatCurrentTime(String timeZone) {
//     final now = DateTime.now();
//     final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
//     formatter.timeZone = timeZone;
//     return formatter.format(now);
//   }
//
//
//   Future<String?> getTimeBasedOnLocation() async {
//     try {
//
//       String? savedTime = sl<AppPrefs>().getString('local_time');
//       if (savedTime != null) {
//         logger.d("🕒 استرجاع الوقت المخزن: $savedTime");
//         return savedTime;
//       }
//
//       String timeZone = await FlutterNativeTimezone.getLocalTimezone();
//
//       final now = DateTime.now();
//       final formattedDate = DateFormat.yMMMMd('ar_SA').add_jm().format(now);
//
//       await sl<AppPrefs>().setString('local_time', formattedDate);
//
//       logger.i("⏰ المنطقة الزمنية: $timeZone - الوقت: $formattedDate");
//       return formattedDate;
//     } catch (e) {
//       logger.e("❌ خطأ أثناء جلب الوقت: $e");
//       return null;
//     }
//   }
// }
