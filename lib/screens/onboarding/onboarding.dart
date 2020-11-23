import 'package:auto_size_text/auto_size_text.dart';
import 'package:easyGroceries/consts.dart';
import 'package:easyGroceries/screens/onboarding/consts.dart';
import 'package:easyGroceries/screens/onboarding/onboardingStates.dart';
import 'package:easyGroceries/utils/colors.dart';
import 'package:easyGroceries/utils/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatelessWidget {
  final OnboardingStates onboardingStates = Get.put(OnboardingStates());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(fit: FlexFit.tight, flex: 1, child: _getStepper()),
          Flexible(fit: FlexFit.tight, flex: 8, child: _getTitle()),
          Flexible(
            fit: FlexFit.tight,
            flex: 16,
            child: _getAnimation(),
          ),
          Flexible(fit: FlexFit.tight, flex: 6, child: _getText()),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: _getButtons(),
          )
        ],
      ),
    );
  }

  _getStepper() {
    return Obx(() => AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: mainColor,
          width: appWidth /
              onboardingSlide.length *
              onboardingStates.onboardingStep.value,
        ));
  }

  _getTitle() {
    return Obx(() => Center(
        child: AutoSizeText(
            onboardingSlide[onboardingStates.onboardingStep.value]["title"],
            maxLines: 1,
            style: textStyleH1)));
  }

  _getAnimation() {
    return Center(
        child: Obx(() => Lottie.asset(
              onboardingSlide[onboardingStates.onboardingStep.value]
                  ["lottiePath"],
            )));
  }

  _getText() {
    return Center(
        child: Obx(() => AutoSizeText(
            onboardingSlide[onboardingStates.onboardingStep.value]["text"],
            maxLines: 2,
            textAlign: TextAlign.center,
            style: textStyleH2)));
  }

  _getButtons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: Center(
                  child: Obx(() =>Visibility(
                visible: onboardingStates.onboardingStep.value != 0,
                child: GestureDetector(
                  onTap: () => onboardingStates
                      .setOnboardingStep(onboardingSlide.length),
                  child: AutoSizeText(
                    "Skip",
                    style: textStyleSkip,
                  ),
                ),
              )))),
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 1,
              child: Center(
                  child: GestureDetector(
                onTap: () => onboardingStates.setOnboardingStep(
                    onboardingStates.onboardingStep.value + 1),
                child: AutoSizeText(
                  "Next",
                  style: textStyleNext,
                ),
              ))),
        ],
      ),
    );
  }
}
