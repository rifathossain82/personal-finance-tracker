import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/user/data/models/user_model.dart';
import 'package:personal_finance_tracker/src/features/user/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = Get.find<UserRepository>();

  Future<Result> login({
    required String email,
    required String password,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user?.emailVerified == true) {
        return Result.success();
      } else {
        await _auth.signOut();
        return Result.failure(Message.pleaseVerifyEmail);
      }
    } on FirebaseAuthException catch (e) {
      Log.error("Error login: ${e.message ?? 'An unknown error occurred'}");
      throw (e.message ?? 'An unknown error occurred');
    } catch (e) {
      rethrow;
    }
  }

  Future<Result> register({
    required String email,
    required String phone,
    required String password,
    required String name,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// Send verification email
      await userCredential.user?.sendEmailVerification();

      /// Save the user ID to local storage
      await LocalStorage.saveData(
        key: LocalStorageKey.userId,
        data: userCredential.user?.uid,
      );

      /// Store user info in Firestore under 'users' collection
      await _userRepository.addUser(
        uid: userCredential.user?.uid,
        data: UserModel(
          name: name,
          email: email,
          phone: phone,
        ),
      );

      return Result.success();
    } on FirebaseAuthException catch (e) {
      Log.error("Error register: ${e.message ?? 'An unknown error occurred'}");
      throw (e.message ?? 'An unknown error occurred');
    } catch (e) {
      rethrow;
    }
  }

  Future<Result> resendVerificationEmail() async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return Result.success();
      } else {
        return Result.failure(Message.emailAlreadyVerifiedOrUserNotLoggedIn);
      }
    } on FirebaseAuthException catch (e) {
      Log.error("Error resend verification email: ${e.toString()}");
      throw ("Failed to send verification email: ${e.toString()}");
    } catch (e) {
      rethrow;
    }
  }

  Future<Result> logout() async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _auth.signOut();
      return Result.success();
    } catch (e) {
      Log.error("Error logout: ${e.toString()}");
      rethrow;
    }
  }

  Future<Result> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      User? user = _auth.currentUser;

      /// Re-authenticate user before changing the password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: oldPassword,
      );

      /// Re-authenticate
      await user?.reauthenticateWithCredential(credential);

      /// Change password
      await user?.updatePassword(newPassword);

      return Result.success();
    } on FirebaseAuthException catch (e) {
      Log.error(
        "Error change password: ${e.message ?? 'An unknown error occurred'}",
      );
      throw (e.message ?? 'Error change password');
    } catch (e) {
      rethrow;
    }
  }

  Future<Result> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _auth.sendPasswordResetEmail(email: email);
      return Result.success();
    } catch (e) {
      Log.error("Error send reset email: ${e.toString()}");
      rethrow;
    }
  }

  /// Get the current user info
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  /// Check if the user is logged in
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  /// Check if the user has verified email or not
  bool hasVerifiedEmail() {
    return _auth.currentUser?.emailVerified ?? false;
  }
}
