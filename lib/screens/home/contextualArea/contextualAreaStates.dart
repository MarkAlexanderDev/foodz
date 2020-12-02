import 'package:EasyGroceries/screens/home/contextualArea/consts.dart';
import 'package:EasyGroceries/services/api/apiStates.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

const CA_SLIDE_ID_RECIEPE = 1;
const CA_SLIDE_ID_MAP = 2;

class ContextualAreaStates extends GetxController {
  static ContextualAreaStates get to => Get.find();
  final ApiStates apiStates = Get.put(ApiStates());

  Future<bool> getSlideData() async {
    recipeOfTheWeek.addAll(await apiStates.getRecipeOfTheWeek());
    caSlides.addAll([
      {
        "title": "RECIPE OF THE WEEK",
        "desc": recipeOfTheWeek[KEY_RECIPE_OF_THE_WEEK_LABEL],
        "image": recipeOfTheWeek[KEY_RECIPE_OF_THE_WEEK_IMG],
        "clickHint": "Let's cook it !",
        "onClick": () {
          Get.toNamed(URL_RECIPE_OF_THE_WEEK, arguments: recipeOfTheWeek);
        }
      },
      {
        "title": "EASYGROCERIES MAP",
        "desc": "Find all the closest grocery stores from you !",
        "image": "",
        "clickHint": "Let's go !",
        "onClick": () async {
          String googleUrl =
              'https://www.google.com/maps/search/grocery+store/';
          if (await canLaunch(googleUrl)) {
            await launch(googleUrl);
          } else {
            Get.snackbar("Error", "Something went wrong!",
                icon: Icon(Icons.warning));
          }
        }
      },
    ]);
    return true;
  }

  RxList caSlides = List().obs;
  RxList recipeOfTheWeek = List().obs;
}
