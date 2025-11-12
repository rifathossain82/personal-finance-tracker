// import 'package:personal_finance_tracker/src/core/core.dart';
// import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
// import 'package:personal_finance_tracker/src/features/user/data/models/user_model.dart';
// import 'package:get/get.dart';
//
// class AuthHelper {
//   /// Returns the current user or shows an error SnackBar if the user is null.
//   /// Useful before any authenticated action (like add or update data).
//   static Future<UserModel?> getCurrentUserOrShowError() async {
//     /// 1. check internet
//     if (!await ConnectivityService.hasInternet) {
//       SnackBarService.showSnackBar(
//         message: Message.noInternet,
//         bgColor: failedColor,
//       );
//       return null;
//     }
//
//     /// 2. fetch current user
//     UserModel? user = PermissionManager().currentUser;
//
//     /// 3. if user null then show a msg & logout current user
//     if (user == null) {
//       Log.debug('User not found in PermissionManager. Logging out...');
//       SnackBarService.showSnackBar(
//         message: 'আপনার তথ্য পাওয়া যায়নি! আবার লগইন করে চেষ্টা করুন',
//         bgColor: failedColor,
//       );
//       await Future.delayed(Duration(milliseconds: 300));
//       await Get.find<AuthController>().logout();
//     }
//
//     /// 4. if all right return user
//     return user;
//   }
//
// }
