// import 'package:personal_finance_tracker/src/core/core.dart';
// import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
// import 'package:personal_finance_tracker/src/features/user/controller/user_controller.dart';
// import 'package:personal_finance_tracker/src/features/user/data/models/user_model.dart';
// import 'package:get/get.dart';
//
// class PermissionManager {
//   static final PermissionManager _instance = PermissionManager._internal();
//
//   factory PermissionManager() => _instance;
//
//   PermissionManager._internal();
//
//   UserModel? _currentUser;
//
//   Future<void> setCurrentUser() async {
//     final userId = LocalStorage.getData(key: LocalStorageKey.userId);
//     final userController = Get.find<UserController>();
//
//     if (userId != null) {
//       final user = await userController.getUser(userId);
//       _currentUser = user;
//     }
//   }
//
//   UserModel? get currentUser => _currentUser;
//
//   bool get isValidUser {
//     final authController = Get.find<AuthController>();
//     return _currentUser != null &&
//         _currentUser!.id != null &&
//         authController.isLoggedIn() &&
//         authController.hasVerifiedEmail();
//   }
//
//   bool get isAdmin => isValidUser && isActive && _currentUser?.isAdmin == true;
//
//   bool get isActive => isValidUser && _currentUser!.status == UserStatus.active.key;
//
//   bool canModifyProfile(String? itemCreatorId) {
//     if (!isValidUser) return false;
//     return _currentUser!.id == itemCreatorId;
//   }
//
//   bool canModifyAsOwner(String? itemCreatorId) {
//     if (!isValidUser || !isActive) return false;
//     return _currentUser!.id == itemCreatorId;
//   }
//
//   bool canModifyAsOwnerOrAdmin(String? itemCreatorId) {
//     if (!isValidUser || !isActive) return false;
//     if (isAdmin) return true;
//     return _currentUser!.id == itemCreatorId;
//   }
//
//   void clear() {
//     _currentUser = null;
//   }
// }
