import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:get/get.dart';

class HomeStates extends GetxController {
  static HomeStates get to => Get.find();

  getData()  {
    name.value = localStorage.getStringData(SHARED_PREF_KEY_USER_NAME);
  }

  RxString name = "".obs;
}
