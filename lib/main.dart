import 'package:EasyGroceries/config.dart';
import 'package:EasyGroceries/screens/home/contextualArea/RecipeOfTheWeek/recipeOfTheWeek.dart';
import 'package:EasyGroceries/screens/profile/profile.dart';
import 'package:EasyGroceries/screens/redirections.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        GetPage(name: URL_RECIPE_OF_THE_WEEK, page: () => RecipeOfTheWeek()),
        GetPage(name: URL_PROFILE, page: () => Profile()),
      ],
    );
  }
}
