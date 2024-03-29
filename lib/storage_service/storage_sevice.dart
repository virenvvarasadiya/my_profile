import 'package:get_storage/get_storage.dart';

class StorageService {
  static final box = GetStorage();

  static write({required String key, required dynamic value}) {
    box.write(key, value);
  }

  static read({required String key}) {
    var value = box.read(key);
    return value;
  }

  static eraseData(){
    box.erase();
  }
}
