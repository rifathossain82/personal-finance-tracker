import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
import 'package:personal_finance_tracker/src/features/auth/data/repositories/auth_repository.dart';
import 'package:personal_finance_tracker/src/features/transaction/controller/transaction_controller.dart';
import 'package:personal_finance_tracker/src/features/transaction/data/repository/transaction_repository.dart';
import 'package:personal_finance_tracker/src/features/user/controller/user_controller.dart';
import 'package:personal_finance_tracker/src/features/user/data/repositories/user_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// Controllers
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => TransactionController(), fenix: true);

    /// Repositories
    Get.lazyPut(() => AuthRepository(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => TransactionRepository(), fenix: true);
  }
}
