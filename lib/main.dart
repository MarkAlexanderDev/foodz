import 'package:device_preview/device_preview.dart';
import 'package:easyGroceries/config.dart';
import 'package:easyGroceries/redirections.dart';
import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      home: Redirections(),
      getPages: [],
    );
  }
}
