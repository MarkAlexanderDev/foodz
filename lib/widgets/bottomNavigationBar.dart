import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const HOME_SCREEN_ID = 0;
const FAV_RECIPE_SCREEN_ID = 1;

class NavBar extends StatelessWidget {
  final int barHeight;
  final sizeIcon;
  final AppStates appStates = Get.put(AppStates());

  NavBar({this.barHeight, this.sizeIcon});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      selectedFontSize: sizeIcon,
      unselectedFontSize: sizeIcon,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: appStates.indexBar.value,
      selectedLabelStyle: textStyleH1Green,
      unselectedLabelStyle: textStyleH1,
      selectedItemColor: mainColor,
      onTap: (index) => {
        appStates.setIndexBar(index)
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Icon(Icons.home)
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Icon(Icons.kitchen)
            ),
            label: "Recipe"),
      ],
    ));
  }
}
