import 'package:EasyGroceries/config.dart';
import 'package:EasyGroceries/screens/home/contextual_area/recipe_of_the_week/recipe_of_the_week.dart';
import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list/grocery_list.dart';
import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list/grocery_list_options/grocery_list_options.dart';
import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list_creation/grocery_list_creation.dart';
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
        GetPage(name: URL_GROCERY_LIST, page: () => GroceryList()),
        GetPage(name: URL_GROCERY_LIST_OPTION, page: () => GroceryListOption()),
        GetPage(
            name: URL_GROCERY_LIST_CREATION, page: () => GroceryListCreation()),
      ],
    );
  }
}
