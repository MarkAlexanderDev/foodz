import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

const CA_SLIDE_ID_RECIEPE = 1;
const CA_SLIDE_ID_MAP = 2;

class ContextualAreaStates extends GetxController {
  static ContextualAreaStates get to => Get.find();

  Future getSlideData() async {
    return [
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
