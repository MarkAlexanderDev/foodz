import 'package:get/get.dart';

class HomeStates extends GetxController {
  static HomeStates get to => Get.find();

  Future<bool> getData() async {
    caSlides.addAll([
      {
        "title": "RECIEPE OF THE WEEK",
        "desc": "Boeuf Bourguignon",
        "image": "",
        "clickHint": "Let's cook it !"
      },
      {
        "title": "EASYGROCERIES MAP",
        "desc": "Find all the closest grocery stores from you !",
        "image": "",
        "clickHint": "Let's go !"
      },
      {
        "title": "SEASONAL FRUITS",
        "desc": "The must-have fruits for this season !",
        "image": "",
        "clickHint": "Let me see !"
      },
    ]);
    return true;
  }

  RxList caSlides = List().obs;
}
