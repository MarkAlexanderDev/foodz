import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  static GroceryListStates get to => Get.find();

  Stream getData() async* {
    databaseReference
        .child(endpointGroceryListIngredient)
        .child(currentGroceryList["uid"])
        .onValue
        .listen((event) async {
      final Map groceryListIngredientIds = Map();
      groceryListIngredientIds.addAll(event.snapshot.value);
      groceryListIngredients.clear();
      await Future.forEach(groceryListIngredientIds.entries, (element) async {
        groceryListIngredients.add([
          element.value["checked"],
          await API.ingredient.getIngredient(element.value["ingredientUid"]),
          element.key
        ]);
      });
    });
    yield true;
  }

  Future<void> deleteIngredient(int index) async {
    await API.groceryListIngredient
        .delete(groceryListIngredients[index][2], currentGroceryList["uid"]);
  }

  Future<void> setIngredientCheckValue(bool value, int index) async {
    GroceryListIngredientModel groceryListIngredient =
        new GroceryListIngredientModel();
    groceryListIngredient.checked = value;
    groceryListIngredient.ingredientId = groceryListIngredients[index][1]["id"];
    await API.groceryListIngredient.update(groceryListIngredient,
        groceryListIngredients[index][2], currentGroceryList["uid"]);
  }

  RxMap currentGroceryList = {}.obs;
  RxList groceryListIngredients = [].obs;
}
