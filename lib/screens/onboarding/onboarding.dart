import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingStates.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/1-onboardingAuth.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/2-onboardingAllergic.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/3-onboardingFavoriteFood.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/4-onboardingProfile.dart';
import 'package:EasyGroceries/services/auth.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const ONBOARDING_STEP_ID_AUTH = 0;
const ONBOARDING_STEP_ID_ALLERGIC = 1;
const ONBOARDING_STEP_ID_FAVORITE_CUISINE = 2;
const ONBOARDING_STEP_ID_PROFILE = 3;

class Onboarding extends StatelessWidget {
  final OnboardingStates onboardingStates = Get.put(OnboardingStates());
  final AppStates appStates = Get.put(AppStates());
  final onboardingSteps = [
    OnboardingAuth(),
    OnboardingAllergic(),
    OnboardingFavoriteFood(),
    OnboardingProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await _previousOnboardingStep());
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Obx(
                    () => _getStepper(onboardingStates.onboardingStep.value))),
            Flexible(
                fit: FlexFit.tight,
                flex: 20,
                child: Obx(() =>
                    onboardingSteps[onboardingStates.onboardingStep.value])),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child:
                  Obx(() => _getButtons(onboardingStates.onboardingStep.value)),
            )
          ],
        ),
      ),
    );
  }

  _getStepper(int onboardingStep) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      color: mainColor,
      width: appWidth / onboardingSteps.length * onboardingStep,
    );
  }

  _getButtons(int onboardingStep) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              visible: onboardingStep > ONBOARDING_STEP_ID_AUTH &&
                  onboardingStep < ONBOARDING_STEP_ID_PROFILE,
              child: Flexible(
                  flex: 1,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        await _skipOnboarding();
                      },
                      child: AutoSizeText(
                        "Skip",
                        style: textStyleSkip,
                      ),
                    ),
                  ))),
          Visibility(
            visible: onboardingStep == ONBOARDING_STEP_ID_PROFILE,
            child: Container(
              width: appWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  onPressed: () async {
                    await _nextOnboardingStep();
                  },
                  child: AutoSizeText("CONFIRM MY INFORMATION"),
                ),
              ),
            ),
          ),
          Visibility(
              visible: onboardingStep > ONBOARDING_STEP_ID_AUTH &&
                  onboardingStep < ONBOARDING_STEP_ID_PROFILE,
              child: Flexible(
                  flex: 1,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        await _nextOnboardingStep();
                      },
                      child: AutoSizeText(
                        "Next",
                        style: textStyleNext,
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  Future<bool> _previousOnboardingStep() async {
    if (onboardingStates.onboardingStep.value > 0) {
      appStates.setLoading(true);
      appStates.currentAccount["onboardingFlag"] =
          onboardingStates.onboardingStep.value - 1;
      await API.account.update(fromMapToAccount(appStates.currentAccount));
      onboardingStates
          .setOnboardingStep(onboardingStates.onboardingStep.value - 1);
      appStates.setLoading(false);
      if (onboardingStates.onboardingStep.value == ONBOARDING_STEP_ID_AUTH)
        await authService.signOut();
    }
    return true;
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    appStates.currentAccount["onboardingFlag"] =
        onboardingStates.onboardingStep.value + 1;
    await API.account.update(fromMapToAccount(appStates.currentAccount));
    onboardingStates
        .setOnboardingStep(onboardingStates.onboardingStep.value + 1);
    appStates.setLoading(false);
  }

  _skipOnboarding() async {
    appStates.setLoading(true);
    appStates.currentAccount["onboardingFlag"] = ONBOARDING_STEP_ID_PROFILE;
    await API.account.update(fromMapToAccount(appStates.currentAccount));
    onboardingStates.setOnboardingStep(ONBOARDING_STEP_ID_PROFILE);
    appStates.setLoading(false);
  }
}
