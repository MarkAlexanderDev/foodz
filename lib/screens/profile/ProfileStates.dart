import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:EasyGroceries/utils/string.dart';
import 'package:get/get.dart';

class ProfileStates extends GetxController {
  static ProfileStates get to => Get.find();

  final AppStates appStates = Get.put(AppStates());

  getData() {
    setName(firstNameAndLastNameToFullName(
        appStates.currentAccount["firstName"],
        appStates.currentAccount["lastName"]));
    setPictureUrl(appStates.currentAccount["pictureUrl"]);
  }

  Future<void> saveData() async {
    appStates.setLoading(true);
    appStates.currentAccount["firstName"] = fullNameToFirstName(name.value);
    appStates.currentAccount["lastName"] = fullNameToLastName(name.value);
    appStates.currentAccount["pictureUrl"] = pictureUrl.value;
    await API.account.update(fromMapToAccount(appStates.currentAccount));
    appStates.setLoading(false);
  }

  void setName(String value) {
    name.value = value;
  }

  void setPictureUrl(String value) {
    pictureUrl.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  RxBool loading = false.obs;
}
