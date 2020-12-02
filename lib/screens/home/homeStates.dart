import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:get/get.dart';

class HomeStates extends GetxController {
  static HomeStates get to => Get.find();

  LocalStorage _localStorage = new LocalStorage();

  Future<bool> getData() async {
    await _localStorage.setStringData(SHARED_PREF_KEY_USER_NAME, name.value);
    return true;
  }

  RxString name = "".obs;
}
