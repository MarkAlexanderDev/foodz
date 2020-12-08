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

  Future getSlideData() async {
    final recipeOfTheWeek = await apiStates.getRecipeOfTheWeek();
    return [
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
        "image":
            "https://searchengineland.com/figz/wp-content/seloads/2014/08/map-local-search-ss-1920.jpg",
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
    ];
  }
}
