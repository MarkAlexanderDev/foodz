import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingProfile extends StatelessWidget {
  final AppStates appStates = Get.put(AppStates());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Center(
              child: Text("profile"),
            ),
            flex: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            Flexible(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await _nextOnboardingStep();
                    },
                    child: AutoSizeText(
                      "Finish",
                      style: textStyleNext,
                    ),
                  ),
                )),
          ],
        ),
        Expanded(child: Container()),
      ],
    );
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    appStates.currentAccount["onboardingFlag"] =
        appStates.currentAccount["onboardingFlag"] + 1;
    await API.account.update(fromMapToAccount(appStates.currentAccount));
    appStates.setLoading(false);
  }
}
