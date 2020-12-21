import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/screens/onboarding/onboardingSteps/3-onboardingFavoriteFood/onboardingFavoriteFoodStates.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingFavoriteFood extends StatefulWidget {
  @override
  _OnboardingFavoriteFood createState() => _OnboardingFavoriteFood();
}

class _OnboardingFavoriteFood extends State<OnboardingFavoriteFood> {
  final OnboardingFavoriteFoodStates onboardingFavoriteFoodStates =
      Get.put(OnboardingFavoriteFoodStates());
  final AppStates appStates = Get.put(AppStates());
  Future _future;

  @override
  void initState() {
    _future = onboardingFavoriteFoodStates.initTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return Column(
              children: [
                Lottie.asset('assets/lotties/food-prepared.json'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: AutoSizeText(
                    "What are your favorite types${nbsp}of${nbsp}food?",
                    style: textStyleH1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: SelectableTags(
                    tagStates: onboardingFavoriteFoodStates.tagsStates,
                    onClickTag: (tag) {
                      onboardingFavoriteFoodStates.setTag(
                          tag.index, tag.active);
                    },
                  ),
                ),
                Expanded(child: Container(), flex: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
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
                        )),
                    Flexible(child: Container(), flex: 1),
                    Flexible(
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
                        )),
                  ],
                ),
                Expanded(child: Container()),
              ],
            );
          else
            return Loading();
        });
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    appStates.currentAccount["onboardingFlag"] =
        appStates.currentAccount["onboardingFlag"] + 1;
    await API.account.update(fromMapToAccount(appStates.currentAccount));
    await onboardingFavoriteFoodStates.pushTags();
    appStates.setLoading(false);
  }

  _skipOnboarding() async {
    appStates.setLoading(true);
    appStates.currentAccount["onboardingFlag"] = ONBOARDING_STEP_ID_PROFILE;
    await API.account.update(fromMapToAccount(appStates.currentAccount));
    appStates.setLoading(false);
  }
}
