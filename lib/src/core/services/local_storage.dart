import 'package:get_storage/get_storage.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class LocalStorage{
  static final _box = GetStorage(AppConstants.packageName);

  static saveData({required LocalStorageKey key, required dynamic data})async{
    await _box.write(key.toString(), data);
  }

  static getData({required LocalStorageKey key}){
    return _box.read(key.toString());
  }

  static Future<void> removeData({required LocalStorageKey key})async{
    await _box.remove(key.toString());
  }

  static removeAllData()async{
    await _box.erase();
  }
}