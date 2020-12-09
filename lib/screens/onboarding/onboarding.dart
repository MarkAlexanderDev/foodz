import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingStates.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/1-onboardingAuth.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding extends StatelessWidget {
  final OnboardingStates onboardingStates = Get.put(OnboardingStates());
  final onboardingSteps = [OnboardingAuth()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(fit: FlexFit.tight, flex: 1, child: _getStepper()),
          Flexible(child: onboardingSteps[0]),
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
    return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: mainColor,
          width: appWidth / onboardingSteps.length * 5,
        );
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
                  child: Visibility(
                        visible: true,
                        child: GestureDetector(
                          onTap: () async {},
                          child: AutoSizeText(
                            "Skip",
                            style: textStyleSkip,
                          ),
                        ),
                      ))),
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 1,
              child: Center(
                  child: GestureDetector(
                onTap: () async {},
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
