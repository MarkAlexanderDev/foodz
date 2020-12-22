import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/screens/states/profile_states.dart';
import 'package:EasyGroceries/services/auth.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
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
  final ProfileStates profileStates = Get.put(ProfileStates());

  @override
  void initState() {
    profileStates.getData();
    profileStates.setLoading(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => !profileStates.loading.value
        ? Scaffold(
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
                          profileStates.setPictureUrl(await getImage(context,
                              !profileStates.pictureUrl.value.isNullOrBlank));
                        },
                        child: Obx(() => ProfilePicture(
                              height: 100,
                              width: 100,
                              pictureUrl: profileStates.pictureUrl.value,
                              editMode: true,
                              onEdit: () async {
                                profileStates.setPictureUrl(await getImage(
                                    context,
                                    !profileStates
                                        .pictureUrl.value.isNullOrBlank));
                              },
                            ))),
                    Container(height: 20),
                    Container(
                      width: appWidth / 2,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        style: textStyleH1,
                        textAlign: TextAlign.center,
                        decoration: getStandardInputDecoration("name", ""),
                        initialValue: profileStates.name.value,
                        onChanged: (value) {
                          profileStates.setName(value);
                        },
                      ),
                    ),
                    Container(height: 20),
                    _ProfileTitle(
                        icon: Icons.local_fire_department,
                        text: "MY COOKING EXPERIENCE"),
                    Container(height: 10),
                    Obx(() => DropdownButton<String>(
                          value: profileStates.getCookingExperienceConverted(
                              profileStates.cookingExperience.value),
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 24,
                          elevation: 16,
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          onChanged: (String value) {
                            profileStates.setCookingExperience(
                                COOKING_EXPERIENCE_IDS.indexOf(value));
                          },
                          items: COOKING_EXPERIENCE_IDS
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: AutoSizeText(value, style: textStyleH2),
                            );
                          }).toList(),
                        )),
                    Container(height: 20),
                    _ProfileTitle(icon: Icons.clear, text: "MY FORBIDDEN FOOD"),
                    Container(height: 10),
                    Container(
                      padding: EdgeInsets.all(24.0),
                      child: SelectableTags(
                        tagStates: profileStates.allergicStates.tagsStates,
                        onClickTag: (tag) {
                          profileStates.allergicStates
                              .setTag(tag.index, tag.active);
                        },
                      ),
                    ),
                    Container(height: 20),
                    _ProfileTitle(
                        icon: Icons.fastfood_rounded,
                        text: "MY FAVORITE CUISINE"),
                    Container(height: 10),
                    Container(
                      padding: EdgeInsets.all(24.0),
                      child: SelectableTags(
                        tagStates: profileStates.favoriteFoodStates.tagsStates,
                        onClickTag: (tag) {
                          profileStates.favoriteFoodStates
                              .setTag(tag.index, tag.active);
                        },
                      ),
                    ),
                    Container(height: 20),
                    _ProfileButon(
                      isFirst: true,
                      icon: Icons.account_tree,
                      text: "SUGGEST A FEATURE",
                      onClick: () {},
                    ),
                    _ProfileButon(
                      icon: Icons.bug_report,
                      text: "REPORT A BUG",
                      onClick: () {},
                    ),
                    _ProfileButon(
                      icon: Icons.logout,
                      text: "LOGOUT",
                      onClick: () async {
                        await authService.signOut();
                        profileStates
                                .appStates.currentAccount["onboardingFlag"] =
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
            floatingActionButton: ConfirmButton(
              onClick: () async {
                await profileStates.saveData();
                Get.toNamed(URL_HOME);
              },
            ))
        : Loading());
  }
}

class _ProfileTitle extends StatelessWidget {
  final IconData icon;
  final String text;

  _ProfileTitle({@required this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: mainColor),
        AutoSizeText(
          text,
          style: textStyleH2GreenUnderline,
        ),
      ],
    );
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
        width: appWidth,
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
