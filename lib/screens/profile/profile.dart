import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/profile/ProfileStates.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profilePicture.dart';
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
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, color: mainColor),
                        AutoSizeText(
                          "MY COOKING EXPERIENCE",
                          style: textStyleH2GreenUnderline,
                        ),
                      ],
                    ),
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
                    Row(
                      children: [
                        Icon(Icons.clear, color: mainColor),
                        AutoSizeText(
                          "MY FORBIDDEN FOOD",
                          style: textStyleH2GreenUnderline,
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Container(
                      padding: EdgeInsets.all(24.0),
                      child: SelectableTags(
                        tagStates:
                            profileStates.onboardingAllergicStates.tagsStates,
                        onClickTag: (tag) {
                          profileStates.onboardingAllergicStates
                              .setTag(tag.index, tag.active);
                        },
                      ),
                    ),
                    Container(height: 20),
                    Row(
                      children: [
                        Icon(Icons.fastfood_rounded, color: mainColor),
                        AutoSizeText(
                          "MY FAVORITE CUISINE",
                          style: textStyleH2GreenUnderline,
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Container(
                      padding: EdgeInsets.all(24.0),
                      child: SelectableTags(
                        tagStates: profileStates
                            .onboardingFavoriteFoodStates.tagsStates,
                        onClickTag: (tag) {
                          profileStates.onboardingFavoriteFoodStates
                              .setTag(tag.index, tag.active);
                        },
                      ),
                    ),
                    Container(height: 20),
                    Container(
                      width: appWidth,
                      height: 25,
                      child: AutoSizeText("SUGGEST A FEATURE",
                          style: textStyleH1Green),
                    ),
                    Container(height: 20),
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
