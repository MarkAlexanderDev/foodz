import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/contextual_area/contextual_area.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final AppStates appStates = Get.put(AppStates());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
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
                pictureUrl: appStates.currentAccount["pictureUrl"],
                editMode: false,
              ),
            ),
          ),
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 1,
              child: AutoSizeText(
                  "Hey there " + appStates.currentAccount["firstName"] + "! ✌️",
                  style: textStyleH1))
        ],
      ),
    );
  }

  _getShoppingListSection() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        AutoSizeText("MY SHOPPING LIST", style: textStyleH2BoldUnderLine),
        Container(height: 25),
        Container(
          height: 125,
          width: appWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.50), BlendMode.darken),
                  image: AssetImage("assets/images/grocery.png"))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "MONDAY’S GROCERY LIST",
                  style: textStyleH1White,
                ),
                AutoSizeText(
                  "All my needs for the week !",
                  style: textStyleH2White,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
