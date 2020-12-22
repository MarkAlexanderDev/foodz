import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding_steps/1_onboarding_auth/onboarding_auth.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding_steps/2_onboarding_allergic/onboarding_allergic.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding_steps/3_onboarding_favorite_food/onboarding_favorite_food.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding_steps/4_onboarding_profile/onboarding_profile.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:EasyGroceries/screens/states/profile_states.dart';
import 'package:EasyGroceries/services/auth.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/service_account.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const ONBOARDING_STEP_ID_AUTH = 0;
const ONBOARDING_STEP_ID_ALLERGIC = 1;
const ONBOARDING_STEP_ID_FAVORITE_CUISINE = 2;
const ONBOARDING_STEP_ID_PROFILE = 3;

class Onboarding extends StatelessWidget {
  final AppStates appStates = Get.put(AppStates());
  final ProfileStates profileStates = Get.put(ProfileStates());
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
          resizeToAvoidBottomPadding: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Obx(() =>
                      _getStepper(appStates.currentAccount["onboardingFlag"]))),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 20,
                  child: Obx(() => onboardingSteps[
                      appStates.currentAccount["onboardingFlag"] == null
                          ? 0
                          : appStates.currentAccount["onboardingFlag"]])),
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: appStates.currentAccount["onboardingFlag"] ==
                ONBOARDING_STEP_ID_PROFILE,
            child: ConfirmButton(onClick: () async {
              appStates.setLoading(true);
              await profileStates.saveData();
              appStates.currentAccount["onboardingFlag"] =
                  appStates.currentAccount["onboardingFlag"] + 1;
              await API.account
                  .update(fromMapToAccount(appStates.currentAccount));
              appStates.setLoading(false);
            }),
          )),
    );
  }

  _getStepper(onboardingStep) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      color: mainColor,
      width: appWidth /
          onboardingSteps.length *
          (onboardingStep == null ? 0 : onboardingStep),
    );
  }

  Future<bool> _previousOnboardingStep() async {
    if (appStates.currentAccount["onboardingFlag"] > 0) {
      appStates.setLoading(true);
      appStates.currentAccount["onboardingFlag"] =
          appStates.currentAccount["onboardingFlag"] - 1;
      await API.account.update(fromMapToAccount(appStates.currentAccount));
      if (appStates.currentAccount["onboardingFlag"] == ONBOARDING_STEP_ID_AUTH)
        await authService.signOut();
      appStates.setLoading(false);
      return false;
    }
    return true;
  }
}
