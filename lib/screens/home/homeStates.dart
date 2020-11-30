import 'package:EasyGroceries/services/api/apiStates.dart';
import 'package:get/get.dart';

const CA_SLIDE_ID_RECIEPE = 1;
const CA_SLIDE_ID_MAP = 2;
const CA_SLIDE_ID_FOOD_SEASON = 3;

class HomeStates extends GetxController {
  static HomeStates get to => Get.find();
  final ApiStates apiStates = Get.put(ApiStates());

  Future<bool> getData() async {
    return true;
  }

  RxList caSlides = List().obs;
  RxList recipeOfTheWeek = List().obs;
}
