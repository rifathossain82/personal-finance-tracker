import 'package:personal_finance_tracker/src/features/auth/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class AuthController extends GetxController {
  final AuthRepository _repository = Get.find<AuthRepository>();

  /// For login page:
  var isLoginLoading = false.obs;
  var isLoginPasswordVisibility = true.obs;
  var isLoginEmailValid = false.obs;
  var isResendVerifyEmailLoading = false.obs;

  /// For forgot password page:
  var isForgotPasswordLoading = false.obs;
  var isForgotPasswordEmailValid = false.obs;

  /// For register page:
  var isRegisterLoading = false.obs;
  var isRegisterPasswordVisibility = true.obs;
  var isRegisterConfirmPasswordVisibility = true.obs;
  var isRegisterEmailValid = false.obs;
  var isPrivacyPolicyChecked = false.obs;

  /// For change password page:
  var isChangePasswordLoading = false.obs;

  /// For create a new password page:
  var isPasswordVisibility = true.obs;
  var isConfirmPasswordVisibility = true.obs;

  /// Others:
  var isProfileUpdateLoading = false.obs;
  var isLogoutLoading = false.obs;

  void togglePrivacyPolicyCheck() {
    isPrivacyPolicyChecked.value = !isPrivacyPolicyChecked.value;
  }

  void recheckLoginEmailValidity(String email) {
    isLoginEmailValid.value = email.isValidEmail;
  }

  void recheckForgotPasswordEmailValidity(String email) {
    isForgotPasswordEmailValid.value = email.isValidEmail;
  }

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisibility.value = !isLoginPasswordVisibility.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisibility.value = !isPasswordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisibility.value = !isConfirmPasswordVisibility.value;
  }

  void recheckRegisterEmailValidity(String email) {
    isRegisterEmailValid.value = email.isValidEmail;
  }

  void toggleRegisterPasswordVisibility() {
    isRegisterPasswordVisibility.value = !isRegisterPasswordVisibility.value;
  }

  void toggleRegisterConfirmPasswordVisibility() {
    isRegisterConfirmPasswordVisibility.value =
        !isRegisterConfirmPasswordVisibility.value;
  }

  bool isLoggedIn() {
    return _repository.isLoggedIn();
  }

  bool hasVerifiedEmail() {
    return _repository.hasVerifiedEmail();
  }

  bool canResendEmail() {
    final String? storedUserId = LocalStorage.getData(
      key: LocalStorageKey.userId,
    );
    return storedUserId != null && !_repository.hasVerifiedEmail();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoginLoading(true);

      Result result = await _repository.login(
        email: email,
        password: password,
      );

      if (result.isSuccess) {
        await _handleLogin();
        Get.offAllNamed(RouteGenerator.transactions);
        SnackBarService.showSnackBar(
          message: Message.loginSuccess,
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? '',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoginLoading(false);
    }
  }

  Future<void> _handleLogin() async {
    try {
      /// 1. Fetch Firebase authenticated user
      User? authUser = await _repository.getCurrentUser();

      if (authUser == null) {
        Log.error('Firebase auth user not found');
        return;
      }

      /// 2. Save the user ID to local storage
      await LocalStorage.saveData(
        key: LocalStorageKey.userId,
        data: authUser.uid,
      );
    } catch (e, s) {
      Log.error('Login error: $e', stackTrace: s);
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      isRegisterLoading(true);

      Result result = await _repository.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );

      if (result.isSuccess) {
        Get.offAllNamed(RouteGenerator.login);
        SnackBarService.showSnackBar(
          message: Message.registerSuccess,
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isRegisterLoading(false);
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      isResendVerifyEmailLoading(true);

      Result result = await _repository.resendVerificationEmail();

      if (result.isSuccess) {
        SnackBarService.showSnackBar(
          message: Message.verificationEmailSent,
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? "",
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isResendVerifyEmailLoading(false);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      isForgotPasswordLoading(true);

      final result = await _repository.sendPasswordResetEmail(
        email: email,
      );

      if (result.isSuccess) {
        Get.offAllNamed(RouteGenerator.login);
        SnackBarService.showSnackBar(
          durationInSeconds: 10,
          message: 'পাসওয়ার্ড রিসেট ইমেইল পাঠানো হয়েছে। আপনার ইমেইল চেক করুন।',
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
      SnackBarService.showSnackBar(
        message: 'ইমেইল পাঠাতে সমস্যা হয়েছে!',
        bgColor: failedColor,
      );
    } finally {
      isForgotPasswordLoading(false);
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      isChangePasswordLoading(true);

      final result = await _repository.changePassword(
        newPassword: newPassword,
        oldPassword: oldPassword,
      );

      if (result.isSuccess) {
        Get.offAllNamed(RouteGenerator.login);
        SnackBarService.showSnackBar(
          durationInSeconds: 3,
          message: 'পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে। অনুগ্রহ করে আবার লগইন করুন।',
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: 'পাসওয়ার্ড পরিবর্তনে সমস্যা হয়েছে!',
        bgColor: failedColor,
      );
    } finally {
      isChangePasswordLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      isLogoutLoading(true);

      Result result = await _repository.logout();

      if (result.isSuccess) {
        Get.offAllNamed(RouteGenerator.dashboard);
        LocalStorage.removeAllData();
        SnackBarService.showSnackBar(
          message: Message.logoutSuccess,
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLogoutLoading(false);
    }
  }
}
