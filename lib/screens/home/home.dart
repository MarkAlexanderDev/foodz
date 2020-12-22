import 'package:EasyGroceries/screens/home/contextual_area/contextual_area.dart';
import 'package:EasyGroceries/screens/home/shopping_lists/shopping_lists.dart';
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        shrinkWrap: true,
        children: [_getProfileSection(), ContextualArea(), ShoppingLists()],
      ),
    );
  }

  _getProfileSection() {
    return Container(
      height: 200,
      child: Center(
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
                    "Hey there " +
                        appStates.currentAccount["firstName"] +
                        "! ✌️",
                    style: textStyleH1))
          ],
        ),
      ),
    );
  }
}
