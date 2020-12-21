import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/2-onboardingAllergic/onboardingAllergicStates.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/3-onboardingFavoriteFood/onboardingFavoriteFoodStates.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:EasyGroceries/utils/string.dart';
import 'package:get/get.dart';

class ProfileStates extends GetxController {
  static ProfileStates get to => Get.find();

  final AppStates appStates = Get.put(AppStates());
  final OnboardingAllergicStates onboardingAllergicStates =
      Get.put(OnboardingAllergicStates());
  final OnboardingFavoriteFoodStates onboardingFavoriteFoodStates =
      Get.put(OnboardingFavoriteFoodStates());

  getData() {
    setName(firstNameAndLastNameToFullName(
        appStates.currentAccount["firstName"],
        appStates.currentAccount["lastName"]));
    setPictureUrl(appStates.currentAccount["pictureUrl"]);
    setCookingExperience(appStates.currentAccount["cookingExperience"]);
    setPeopleNumber(appStates.currentAccount["peopleNumber"]);
    onboardingAllergicStates.initTags();
    onboardingFavoriteFoodStates.initTags();
  }

  Future<void> saveData() async {
    appStates.setLoading(true);
    appStates.currentAccount["firstName"] = fullNameToFirstName(name.value);
    appStates.currentAccount["lastName"] = fullNameToLastName(name.value);
    appStates.currentAccount["pictureUrl"] = pictureUrl.value;
    appStates.currentAccount["cookingExperience"] = cookingExperience.value;
    appStates.currentAccount["peopleNumber"] = peopleNumber.value;
    await onboardingAllergicStates.pushTags();
    await onboardingFavoriteFoodStates.pushTags();
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
    print(value);
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
