import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:EasyGroceries/screens/states/profile_states.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/utils/string.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GroceryListCreation extends StatefulWidget {
  @override
  _GroceryListCreation createState() => _GroceryListCreation();
}

class _GroceryListCreation extends State<GroceryListCreation> {
  final AppStates appStates = Get.put(AppStates());
  final ProfileStates profileStates = Get.put(ProfileStates());

  @override
  void initState() {
    profileStates.setName(firstNameAndLastNameToFullName(
        appStates.currentAccount["firstName"],
        appStates.currentAccount["lastName"]));
    profileStates.setPictureUrl(appStates.currentAccount["pictureUrl"]);
    profileStates.setPeopleNumber(appStates.currentAccount["peopleNumber"]);
    profileStates
        .setCookingExperience(appStates.currentAccount["cookingExperience"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                profileStates.setPictureUrl(await getImage(
                    context, !profileStates.pictureUrl.value.isNullOrBlank));
              },
              child: Obx(() => ProfilePicture(
                    name: null,
                    pictureUrl: profileStates.pictureUrl.value,
                    editMode: true,
                    height: 100,
                    width: 100,
                    onEdit: () async {
                      profileStates.setPictureUrl(await getImage(context,
                          !profileStates.pictureUrl.value.isNullOrBlank));
                    },
                  )),
            ),
            Container(
              width: appWidth,
              height: appHeight * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How should we call you?",
                  style: textStyleH2,
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: textStyleH2,
              decoration: getStandardInputDecoration("", ""),
              initialValue: profileStates.name.value,
              onChanged: (value) {
                profileStates.setName(value);
              },
            ),
            Container(
              width: appWidth,
              height: appHeight * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How many people are living with you ?",
                  style: textStyleH2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              style: textStyleH2,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: getStandardInputDecoration("", ""),
              initialValue: (profileStates.peopleNumber.value == -1
                      ? appStates.currentAccount["peopleNumber"]
                      : profileStates.peopleNumber.value)
                  .toString(),
              onChanged: (value) {
                profileStates.setPeopleNumber(int.parse(value));
              },
            ),
            Container(
              width: appWidth,
              height: appHeight * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "What is your cooking experience ?",
                  style: textStyleH2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(height: appHeight * 0.025),
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
          ],
        ),
      ),
    );
  }
}
