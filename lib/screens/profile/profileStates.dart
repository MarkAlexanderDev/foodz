import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:get/get.dart';

class ProfileStates extends GetxController {
  static ProfileStates get to => Get.find();

  void setName(String newName) {
    name.value = newName;
  }

  void setPictureUrl(String newPictureUrl) {
    if (!newPictureUrl.isNull) {
      if (newPictureUrl != "" && newPictureUrl[0] == "/")
        pictureUrl.value = newPictureUrl.substring(1);
      pictureUrl.value = newPictureUrl;
    }
  }

  Future<void> saveData() async {
    await localStorage.setStringData(SHARED_PREF_KEY_USER_NAME, name.value);
    await localStorage.setStringData(
        SHARED_PREF_KEY_USER_PIC_URL, pictureUrl.value);
  }

  RxString name = localStorage.getStringData(SHARED_PREF_KEY_USER_NAME).obs;
  RxString pictureUrl =
      localStorage.getStringData(SHARED_PREF_KEY_USER_PIC_URL).obs;
}
