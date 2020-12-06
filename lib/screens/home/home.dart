import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/contextualArea/contextualArea.dart';
import 'package:EasyGroceries/screens/home/homeStates.dart';
import 'package:EasyGroceries/screens/profile/profileStates.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/widgets/profilePicture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final HomeStates homeStates = Get.put(HomeStates());
  final ProfileStates profileStates = Get.put(ProfileStates());

  @override
  void initState() {
    homeStates.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: _getProfileSection(),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: ContextualArea(),
        ),
        Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: _getShoppingListSection(),
        )
      ],
    ));
  }

  _getProfileSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child: GestureDetector(
              onTap: () => Get.toNamed(URL_PROFILE),
              child: ProfilePicture(
                height: 100,
                width: 100,
                pictureUrl: profileStates.pictureUrl.value,
                editMode: false,
              ),
            ),
          ),
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 1,
              child: AutoSizeText("Hey there " + homeStates.name.value + "! ✌️",
                  style: textStyleH1))
        ],
      ),
    );
  }

  _getShoppingListSection() {
    return Container(
      width: appWidth,
      color: mainColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          "MY NEXT GROCERY SHOPPING LIST",
          style: textStyleH3Bold,
          maxLines: 1,
        ),
      ),
    );
  }
}
