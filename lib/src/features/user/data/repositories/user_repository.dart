import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/core/services/image_uploader_services.dart';
import 'package:personal_finance_tracker/src/features/user/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = "users";

  /// 🔹 Fetch all user list
  Future<List<Map<String, dynamic>>> getUserList() async {
    try {
      final snapshot = await _db
          .collection(_collectionName)
          .orderBy("timestamp", descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// 🔹 Fetch single user by uid
  Future<Map<String, dynamic>?> getUser(String? uid) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      DocumentSnapshot userDoc =
      await _db.collection(_collectionName).doc(uid).get();

      if (userDoc.exists) {
        Log.info(userDoc.data().toString());
        return userDoc.data() as Map<String, dynamic>;
      } else {
        Log.error('User not found');
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 🔹 Add a new user
  Future<Result> addUser({
    required String? uid,
    required UserModel data,
    String? imagePath,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      /// Firestore Collection Reference
      DocumentReference docRef = _db.collection(_collectionName).doc(uid);

      /// Prepare final request data
      Map<String, dynamic> requestData = data.toJsonForAdd();

      /// Image URL
      String? imageURL = '';

      /// If has image file:
      if (imagePath != null) {
        imageURL = await ImageUploaderServices.uploadImageToServer(imagePath);
      }

      /// Overwrite fields with new values
      requestData.addAll({
        "id": uid,
        "image": imageURL,
        "timestamp": FieldValue.serverTimestamp(),
      });

      Log.debug("Request Data: ${requestData.toString()}");

      /// Save to Firestore
      await docRef.set(requestData);

      Log.debug("User added successfully!");

      return Result.success();
    } catch (e) {
      Log.error("Error adding professional: $e");
      rethrow;
    }
  }

  /// 🔹 Update a user
  Future<Result> updateUser({
    required String id,
    required UserModel data,
    String? imagePath,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      /// Prepare final request data
      Map<String, dynamic> requestData = data.toJsonForUpdate();

      /// Image URL
      String? imageURL;

      /// If has image file:
      if (imagePath != null) {
        imageURL = await ImageUploaderServices.uploadImageToServer(imagePath);

        /// Overwrite fields with new values
        requestData.addAll({
          "image": imageURL ?? data.image,
        });

      }

      Log.debug("Request Data: ${requestData.toString()}");

      await _db.collection(_collectionName).doc(id).update(requestData);
      return Result.success();
    } on FirebaseException catch (e) {
      Log.error("Error updating user: $e");
      throw (e.message ?? "An unknown error occurred");
    } catch (e) {
      rethrow;
    }
  }

  /// 🔹 Delete a user
  Future<Result> deleteUser({required String id}) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _db.collection(_collectionName).doc(id).delete();
      return Result.success();
    } catch (e) {
      Log.error("Error deleting user: $e");
      rethrow;
    }
  }
}
