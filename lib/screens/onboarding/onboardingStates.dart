import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:get/get.dart';

class OnboardingStates extends GetxController {
  static OnboardingStates get to => Get.find();

  void setOnboardingStep(int value) {
    onboardingStep.value = value;
  }

  RxInt onboardingStep = ONBOARDING_STEP_ID_AUTH.obs;
}
