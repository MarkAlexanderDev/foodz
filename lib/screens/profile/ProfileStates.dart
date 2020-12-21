import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/screens/consts.dart';
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
    appStates.currentAccount["cookingExperience"] = cookingExperience.value;
    appStates.currentAccount["peopleNumber"] = peopleNumber.value;
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

  void setPeopleNumber(String value) {
    peopleNumber.value = int.parse(value);
  }

  void setCookingExperience(String value) {
    cookingExperience.value = COOKING_EXPERIENCE_IDS.indexOf(value);
  }

  getCookingExperienceConverted(int value) {
    return COOKING_EXPERIENCE_IDS[value];
  }

  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  RxInt cookingExperience = (-1).obs;
  RxInt peopleNumber = (-1).obs;
  RxBool loading = false.obs;
}
