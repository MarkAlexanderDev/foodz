import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/states/allergic_states.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:EasyGroceries/screens/states/favorite_food_states.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/service_account.dart';
import 'package:EasyGroceries/utils/string.dart';
import 'package:get/get.dart';

class ProfileStates extends GetxController {
  static ProfileStates get to => Get.find();

  final AppStates appStates = Get.put(AppStates());
  final AllergicStates allergicStates = Get.put(AllergicStates());
  final FavoriteFoodStates favoriteFoodStates = Get.put(FavoriteFoodStates());

  getData() {
    setName(firstNameAndLastNameToFullName(
        appStates.currentAccount["firstName"],
        appStates.currentAccount["lastName"]));
    setPictureUrl(appStates.currentAccount["pictureUrl"]);
    setCookingExperience(appStates.currentAccount["cookingExperience"]);
    setPeopleNumber(appStates.currentAccount["peopleNumber"]);
    allergicStates.initTags();
    favoriteFoodStates.initTags();
  }

  Future<void> saveData() async {
    appStates.setLoading(true);
    appStates.currentAccount["firstName"] = fullNameToFirstName(name.value);
    appStates.currentAccount["lastName"] = fullNameToLastName(name.value);
    appStates.currentAccount["pictureUrl"] = pictureUrl.value;
    appStates.currentAccount["cookingExperience"] = cookingExperience.value;
    appStates.currentAccount["peopleNumber"] = peopleNumber.value;
    await allergicStates.pushTags();
    await favoriteFoodStates.pushTags();
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

  void setPeopleNumber(int value) {
    peopleNumber.value = value;
  }

  void setCookingExperience(int value) {
    cookingExperience.value = value;
  }

  String getCookingExperienceConverted(int value) {
    return COOKING_EXPERIENCE_IDS[value];
  }

  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  RxInt cookingExperience = (-1).obs;
  RxInt peopleNumber = (-1).obs;
  RxBool loading = false.obs;
}
