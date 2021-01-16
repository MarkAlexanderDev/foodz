import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/states/account_states.dart';
import 'package:EasyGroceries/states/allergy_tags_states.dart';
import 'package:EasyGroceries/states/app_states.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingAllergic extends StatefulWidget {
  @override
  _OnboardingAllergic createState() => _OnboardingAllergic();
}

class _OnboardingAllergic extends State<OnboardingAllergic> {
  Future _future;

  @override
  void initState() {
    _future = allergyTagsStates.getTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Lottie.asset('assets/lotties/vr-sickness.json'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: AutoSizeText(
                    "Do you have specific food that you do not eat or you are allergic of ?",
                    style: textStyleH1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: SelectableTags(
                    tagStates: allergyTagsStates.tagsStates,
                    onClickTag: (tag) {
                      allergyTagsStates.setTag(tag.index, tag.active);
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
          } else
            return Loading();
        });
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    accountStates.account.value.onboardingFlag =
        accountStates.account.value.onboardingFlag + 1;
    await accountStates.updateAccount();
    await allergyTagsStates.updateTags();
    appStates.setLoading(false);
  }

  _skipOnboarding() async {
    appStates.setLoading(true);
    accountStates.account.value.onboardingFlag = ONBOARDING_STEP_ID_PROFILE;
    accountStates.updateAccount();
    appStates.setLoading(false);
  }
}
