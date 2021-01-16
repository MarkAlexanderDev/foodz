import 'package:EasyGroceries/screens/home/home.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';
import 'package:EasyGroceries/screens/recipes/recipes.dart';
import 'package:EasyGroceries/services/database/models/account_model.dart';
import 'package:EasyGroceries/states/account_states.dart';
import 'package:EasyGroceries/states/app_states.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/widgets/bottom_navigation_bar.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Redirections extends StatefulWidget {
  @override
  _Redirections createState() => _Redirections();
}

class _Redirections extends State<Redirections> {
  Future<bool> _future;

  Future<bool> loader() async {
    await appStates.initApp();
    await accountStates.getAccount();
    return true;
  }

  @override
  void initState() {
    _future = loader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData)
            return Obx(() =>
                _getPage(accountStates.account.value, appStates.loading.value));
          else
            return Loading();
        });
  }

  _getPage(AccountModel user, bool loading) {
    final List appScreens = [Home(), Recipes()];
    if (loading)
      return Container(color: Colors.white, child: Loading());
    else if (user == null ||
        user.onboardingFlag < ONBOARDING_STEP_ID_PROFILE + 1)
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
                  "Hey there " + accountStates.account.value.name + "! ✌️",
                  style: textStyleH1,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => Get.toNamed(URL_PROFILE),
                  child: ProfilePicture(
                    name: null,
                    height: 50,
                    width: 50,
                    pictureUrl: accountStates.account.value.pictureUrl,
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
