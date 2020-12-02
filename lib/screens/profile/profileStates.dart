import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:get/get.dart';

class ProfileStates extends GetxController {
  static ProfileStates get to => Get.find();
  LocalStorage _localStorage = new LocalStorage();

  void setLoading(bool newLoading) {
    loading.value = newLoading;
  }

  void setName(String newName) {
    name.value = newName;
  }

  void setPictureUrl(String newPictureUrl) {
    pictureUrl.value = newPictureUrl;
  }

  Future<bool> getData() async {
    name.value = await _localStorage.getStringData(SHARED_PREF_KEY_USER_NAME);
    pictureUrl.value =
        await _localStorage.getStringData(SHARED_PREF_KEY_USER_PIC_URL);
    return true;
  }

  Future<void> saveData() async {
    await _localStorage.setStringData(SHARED_PREF_KEY_USER_NAME, name.value);
    await _localStorage.setStringData(
        SHARED_PREF_KEY_USER_PIC_URL, pictureUrl.value);
  }

  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  RxBool loading = false.obs;
}
