import 'package:EasyGroceries/utils/urlLauncher.dart';
import 'package:get/get.dart';

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
          await launchUrl(googleUrl);
        }
      },
    ];
  }
}
