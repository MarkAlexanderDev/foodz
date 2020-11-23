import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  setIsOnboardingDone(value) {
    isOnboardingDone.value = value;
  }

  RxBool isOnboardingDone = false.obs;
}
