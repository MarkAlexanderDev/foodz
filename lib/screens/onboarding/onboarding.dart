import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/1-onboardingAuth/onboardingAuth.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/2-onboardingAllergic/onboardingAllergic.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/3-onboardingFavoriteFood/onboardingFavoriteFood.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/4-onboardingProfile/onboardingProfile.dart';
import 'package:EasyGroceries/screens/profile/ProfileStates.dart';
import 'package:EasyGroceries/services/auth.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
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
