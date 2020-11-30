import 'package:EasyGroceries/services/api/api.dart';
import 'package:EasyGroceries/services/api/apiInterceptor.dart';
import 'package:EasyGroceries/services/api/consts.dart';
import 'package:EasyGroceries/services/localStorage/consts.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:EasyGroceries/utils/date.dart';
import 'package:get/get.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ApiStates extends GetxController {
  static ApiStates get to => Get.find();

  LocalStorage localStorage = LocalStorage();

  Future<List<String>> getRecipeOfTheWeek() async {
    final int recipeId = weekNumber(DateTime.now());

    if (await localStorage.getIntData(SHARED_PREF_KEY_CURRENT_WEEK_NB) !=
        recipeId) {
      await localStorage.setIntData(SHARED_PREF_KEY_CURRENT_WEEK_NB, recipeId);
      final Api api = Api(
          client: HttpClientWithInterceptor.build(
              interceptors: [ApiInterceptor()]));
      final res = await api.get(
          path: API_PATH_RECIPE +
              "?app_id=" +
              API_ID_RECIPE +
              "&app_key=" +
              API_KEY_RECIPE +
              "&q=chicken" +
              "&from=" +
              recipeId.toString() +
              "&to=" +
              (recipeId + 1).toString());
      final List<String> recipeOfTheWeek = List();
      recipeOfTheWeek.add(res["hits"][0]["recipe"]["label"]);
      recipeOfTheWeek.add(res["hits"][0]["recipe"]["image"]);
      recipeOfTheWeek.add(res["hits"][0]["recipe"]["url"]);
      recipeOfTheWeek.add((res["hits"][0]["recipe"]["calories"]).toString());
      recipeOfTheWeek
        ..addAll(
            new List<String>.from(res["hits"][0]["recipe"]["ingredientLines"]));
      await localStorage.setStringListData(
          SHARED_PREF_KEY_RECIPE_OF_THE_WEEK, recipeOfTheWeek);
      return recipeOfTheWeek;
    } else {
      return localStorage.getStringListData(SHARED_PREF_KEY_RECIPE_OF_THE_WEEK);
    }
  }
}
