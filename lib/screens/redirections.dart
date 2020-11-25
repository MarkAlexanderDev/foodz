import 'package:EasyGroceries/screens/appStates.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/home.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/utils/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Redirections extends StatelessWidget {
  final AppStates appStates = Get.put(AppStates());

  _initApp(context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    _initApp(context);
    return FutureBuilder(
        future: appStates.getData(),
        builder: (BuildContext context, res) {
          if (res.hasData)
            return Obx(() => _getPage(appStates.isOnboardingDone.value));
          else
            return Loading();
        });
  }

  _getPage(bool isOnboardingDone) {
    if (!isOnboardingDone)
      return Onboarding();
    else
      return Home();
  }
}
