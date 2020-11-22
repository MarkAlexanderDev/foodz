import 'package:easyGroceries/appStates.dart';
import 'package:easyGroceries/consts.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    _initApp(context);
    return Scaffold(
      body: Center(
        child: Text("Hello world!"),
      ),
    );
  }
}
