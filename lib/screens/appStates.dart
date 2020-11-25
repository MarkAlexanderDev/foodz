import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  LocalStorage localStorage = LocalStorage();

  setIsOnboardingDone(value) async {
    isOnboardingDone.value = value;
    await localStorage.setBoolData(SHARED_PREF_KEY_IS_ONBOARDING_DONE, value);
  }

  RxBool isOnboardingDone = false.obs;

  Future<bool> getData() async {
    isOnboardingDone.value =
        await localStorage.getBoolData(SHARED_PREF_KEY_IS_ONBOARDING_DONE);
    return true;
  }
}
