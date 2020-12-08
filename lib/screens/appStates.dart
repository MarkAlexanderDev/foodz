import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:EasyGroceries/widgets/bottomNavigationBar.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  Future<bool> getData() async {
    await localStorage.init();
    isOnboardingDone.value =
        localStorage.getBoolData(SHARED_PREF_KEY_IS_ONBOARDING_DONE);
    return true;
  }

  setIsOnboardingDone(value) async {
    isOnboardingDone.value = value;
    await localStorage.setBoolData(SHARED_PREF_KEY_IS_ONBOARDING_DONE, value);
  }

  void setIndexBar(int value) {
    indexBar.value = value;
  }

  RxBool isOnboardingDone = false.obs;
  RxInt indexBar = HOME_SCREEN_ID.obs;
}
