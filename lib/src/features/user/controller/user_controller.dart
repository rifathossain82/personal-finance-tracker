import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/user/data/models/user_model.dart';
import 'package:personal_finance_tracker/src/features/user/data/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _repository = Get.find<UserRepository>();

  var isUserUpdating = false.obs;
  var isUserListLoading = false.obs;
  var userList = <UserModel>[].obs;

  var selectedTabIndex = RxInt(0);
  var searchQuery = RxnString();
  var filteredUserList = <UserModel>[].obs;

  void changedTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  bool get hasSearchQuery => searchQuery.value?.isNotEmpty ?? false;

  void changedSearchQuery(String? value) {
    searchQuery.value = value;
  }

  void getFilteredUsers() {
    filteredUserList.value = userList.where((pro) {
      final query = searchQuery.value?.toLowerCase() ?? '';
      final matchesQuery = pro.name?.toLowerCase().contains(query) == true ||
          pro.email?.toLowerCase().contains(query) == true ||
          pro.phone?.contains(query) == true;

      return query.isEmpty || matchesQuery;
    }).toList();
  }

  Future<void> getUserList() async {
    try {
      isUserListLoading(true);

      final responseBody = await _repository.getUserList();
      userList.value = responseBody.map((e) => UserModel.fromJson(e)).toList();

      Log.debug("Response Body: $responseBody");
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isUserListLoading(false);
    }
  }

  Future<UserModel?> getCurrentUser() async {
    String? userId = LocalStorage.getData(key: LocalStorageKey.userId);
    return getUser(userId);
  }

  Future<UserModel?> getUser(String? uid) async {
    try {
      final responseBody = await _repository.getUser(uid);
      if (responseBody != null) {
        return UserModel.fromJson(responseBody);
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
    }
    return null;
  }

  Future<void> updateUser({
    required String userId,
    required UserModel updatedData,
    String? imagePath,
  }) async {
    try {
      isUserUpdating(true);

      final result = await _repository.updateUser(
        id: userId,
        data: updatedData,
        imagePath: imagePath,
      );

      if (result.isSuccess) {
        await getUserList();
        SnackBarService.showSnackBar(
          message: Message.dataUpdated,
          bgColor: successColor,
        );
      }
    } catch (error, stackTrace) {
      SnackBarService.showSnackBar(
        message: Message.dataUpdateFailed,
        bgColor: failedColor,
      );
      Log.error('User update failed: $error', stackTrace: stackTrace);
    } finally {
      isUserUpdating(false);
    }
  }
}
