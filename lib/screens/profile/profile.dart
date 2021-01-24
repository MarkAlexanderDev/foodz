import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/services/auth.dart';
import 'package:EasyGroceries/states/account_states.dart';
import 'package:EasyGroceries/states/allergy_tags_states.dart';
import 'package:EasyGroceries/states/app_states.dart';
import 'package:EasyGroceries/states/favorite_food_tags_states.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/utils/urlLauncher.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:EasyGroceries/widgets/section_title.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final AccountStates accountStates = Get.put(AccountStates());
  final AllergyTagsStates allergyTagsStates = Get.put(AllergyTagsStates());
  final FavoriteFoodTagsStates favoriteFoodTagsStates =
      Get.put(FavoriteFoodTagsStates());
  Future _future;

  @override
  void initState() {
    _future = _getTages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: AutoSizeText(
                            "MY PROFILE",
                            style: textStyleH1,
                          ),
                        ),
                        Container(height: 20),
                        GestureDetector(
                            onTap: () async {
                              await _onEditPicture(context);
                            },
                            child: Obx(() => ProfilePicture(
                                  height: 100,
                                  width: 100,
                                  pictureUrl:
                                      accountStates.account.value.pictureUrl,
                                  name: null,
                                  editMode: true,
                                  onEdit: () async {
                                    await _onEditPicture(context);
                                  },
                                ))),
                        Container(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            style: textStyleH1,
                            textAlign: TextAlign.center,
                            decoration: getStandardInputDecoration("name", ""),
                            initialValue: accountStates.account.value.name,
                            onChanged: (value) {
                              accountStates.account.value.name = value;
                            },
                          ),
                        ),
                        Container(height: 20),
                        SectionTitle(
                            icon: Icons.local_fire_department,
                            text: "MY COOKING EXPERIENCE"),
                        Container(height: 10),
                        Obx(() => DropdownButton<String>(
                              value: accountStates
                                  .getCookingExperienceConverted(accountStates
                                      .account.value.cookingExperience),
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              onChanged: (String value) {
                                accountStates.account.value.cookingExperience =
                                    COOKING_EXPERIENCE_IDS.indexOf(value);
                              },
                              items: COOKING_EXPERIENCE_IDS
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                      AutoSizeText(value, style: textStyleH2),
                                );
                              }).toList(),
                            )),
                        Container(height: 20),
                        SectionTitle(
                            icon: Icons.clear, text: "MY FORBIDDEN FOOD"),
                        Container(height: 10),
                        Container(
                          padding: EdgeInsets.all(24.0),
                          child: SelectableTags(
                            tags: allergyTagsStates.tags,
                            onClickTag: (tag) {
                              allergyTagsStates.setTag(tag.index, tag.active);
                            },
                          ),
                        ),
                        Container(height: 20),
                        SectionTitle(
                            icon: Icons.fastfood_rounded,
                            text: "MY FAVORITE CUISINE"),
                        Container(height: 10),
                        Container(
                          padding: EdgeInsets.all(24.0),
                          child: SelectableTags(
                            tags: favoriteFoodTagsStates.tags,
                            onClickTag: (tag) {
                              favoriteFoodTagsStates.setTag(
                                  tag.index, tag.active);
                            },
                          ),
                        ),
                        Container(height: 20),
                        _ProfileButon(
                          isFirst: true,
                          icon: Icons.account_tree,
                          text: "SUGGEST A FEATURE",
                          onClick: () async {
                            await launchUrl(
                                "https://c0l0dpj04sd.typeform.com/to/GaQDfqZh");
                          },
                        ),
                        _ProfileButon(
                          icon: Icons.bug_report,
                          text: "REPORT A BUG",
                          onClick: () async {
                            await launchUrl(
                                "https://c0l0dpj04sd.typeform.com/to/ITUBtkL3");
                          },
                        ),
                        _ProfileButon(
                          icon: Icons.logout,
                          text: "LOGOUT",
                          onClick: () async {
                            await authService.signOut();
                            accountStates.account.value.onboardingFlag =
                                ONBOARDING_STEP_ID_AUTH;
                            Get.toNamed("/");
                          },
                        ),
                        Container(height: 50),
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Obx(() => ConfirmButton(
                      enabled: !appStates.uploadingProfilePicture.value,
                      onClick: () async {
                        await accountStates.updateAccount();
                        Get.toNamed(URL_HOME);
                      },
                    )));
          else
            return Loading();
        });
  }

  Future<void> _onEditPicture(context) async {
    final String imgPath = await getImage(
        context, !accountStates.account.value.pictureUrl.isNullOrBlank);
    accountStates.account.update((account) {
      if (!imgPath.isNull) account.pictureUrl = imgPath;
    });
  }

  Future<bool> _getTages() async {
    await allergyTagsStates.getTags();
    await favoriteFoodTagsStates.getTags();
    return true;
  }
}

class _ProfileButon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onClick;
  final bool isFirst;

  _ProfileButon({this.isFirst, @required this.icon, this.text, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: isFirst.isNull || !isFirst
                        ? Colors.transparent
                        : mainColor),
                left: BorderSide(color: mainColor),
                right: BorderSide(color: mainColor),
                bottom: BorderSide(color: mainColor))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, color: mainColor),
              Container(width: 25),
              AutoSizeText(text, style: textStyleH1Green),
            ],
          ),
        ),
      ),
    );
  }
}
