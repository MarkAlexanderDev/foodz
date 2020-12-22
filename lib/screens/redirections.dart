import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/home.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/screens/recipes/recipes.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/widgets/bottom_navigation_bar.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Redirections extends StatefulWidget {
  @override
  _Redirections createState() => _Redirections();
}

class _Redirections extends State<Redirections> {
  final AppStates appStates = Get.put(AppStates());
  Future<bool> _future;

  @override
  void initState() {
    _future = appStates.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initApp(context);
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, res) {
          if (res.hasData)
            return Obx(() =>
                _getPage(appStates.currentAccount, appStates.loading.value));
          else
            return Loading();
        });
  }

  _initApp(context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;
    appViewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;
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

  _getPage(currentUser, loading) {
    final List appScreens = [Home(), Recipes()];
    if (loading)
      return Loading();
    else if (currentUser.isEmpty ||
        currentUser["onboardingFlag"] < ONBOARDING_STEP_ID_PROFILE + 1)
      return Onboarding();
    else
      return Scaffold(
          body: appScreens[appStates.indexBar.value],
          appBar: _getFoodzAppBar(),
          bottomNavigationBar: NavBar(sizeIcon: 25.0));
  }

  _getFoodzAppBar() {
    return AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Expanded(
            child: Row(
              children: [
                Container(width: 20),
                AutoSizeText(
                  "Hey there " + appStates.currentAccount["firstName"] + "! ✌️",
                  style: textStyleH1,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => Get.toNamed(URL_PROFILE),
                  child: ProfilePicture(
                    height: 50,
                    width: 50,
                    pictureUrl: appStates.currentAccount["pictureUrl"],
                    editMode: false,
                  ),
                ),
                Container(width: 20),
              ],
            ),
          )
        ]);
  }
}
