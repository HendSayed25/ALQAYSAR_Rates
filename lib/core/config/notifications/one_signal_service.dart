// import 'package:alqaysar_rates/core/config/supabase/supabase_client.dart';
//
// class OneSignalService {
//   OneSignalService();
//
//   Future<void> sendNotificationToUsers({
//     required String message,
//     required List<String> externalUserIds,
//   }) async {
//     try {
//       final response = await SupabaseClientProvider.client.functions
//           .invoke('pushNotification', body: {
//         'message': message,
//         'externalUserIds': externalUserIds,
//       });
//
//       if (response.status == 200) {
//         print("Notification sent successfully: ${response.data}");
//       } else {
//         print("Failed to send notification: ${response.data}");
//       }
//     } catch (e) {
//       print("Error sending notification: $e");
//     }
//   }
// }
