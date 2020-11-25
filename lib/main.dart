import 'package:EasyGroceries/config.dart';
import 'package:EasyGroceries/screens/redirections.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  if (EnvironmentConfig.ENABLE_DEVICE_PREVEW)
    runApp(MaterialApp(
        home: DevicePreview(builder: (context) => Scaffold(body: MyApp()))));
  else
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: mainColor,
        ),
      ),
      getPages: [
        GetPage(
          name: "/",
          page: () => AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: Redirections()),
        ),
      ],
    );
  }
}
