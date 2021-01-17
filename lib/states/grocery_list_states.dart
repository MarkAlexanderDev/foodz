import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_grocery_list_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  static GroceryListStates get to => Get.find();

  Stream streamGroceryList() async* {
    databaseReference
        .child(endpointGroceryListIngredient)
        .child(groceryList.value.uid)
        .onValue
        .listen((event) async {
      final Map snapshot = new Map<String, dynamic>.from(event.snapshot.value);
      for (int i = 0; i < snapshot.length; i++) {
        final GroceryListIngredientModel groceryListModel =
            new GroceryListIngredientModel();
        groceryListModel.fromJson(snapshot.entries.elementAt(i).value);
        if (groceryListIngredients.length <= i) {
          groceryListIngredientsKeys.add(snapshot.entries.elementAt(i).key);
          groceryListIngredients.add(groceryListModel);
        } else
          groceryListIngredients[i] = groceryListModel;
      }
    });
    yield true;
  }

  Future<void> createGroceryList() async {
    await API.groceryList.create(groceryListStates.groceryList.value);
    AccountGroceryListModel accountGroceryList = new AccountGroceryListModel();
    accountGroceryList.groceryListUid = groceryListStates.groceryList.value.uid;
    await API.accountGroceryList.create(accountGroceryList);
    GroceryListIngredientModel groceryListIngredient =
        new GroceryListIngredientModel();
    groceryListIngredient.checked = false;
    await API.groceryListIngredient.create("baguette", groceryListIngredient,
        groceryListStates.groceryList.value.uid);
  }

  Future<void> updateGroceryList() async {
    await API.groceryList.update(groceryList.value);
  }

  Future<void> addIngredient(String ingredient) async {
    if (!groceryListIngredientsKeys.contains(ingredient)) {
      GroceryListIngredientModel groceryListIngredient =
          new GroceryListIngredientModel();
      groceryListIngredient.checked = false;
      groceryListIngredients.add(groceryListIngredient);
      groceryListIngredients.refresh();
      groceryListIngredientsKeys.add(ingredient);
      groceryListIngredientsKeys.refresh();
      await API.groceryListIngredient
          .create(ingredient, groceryListIngredient, groceryList.value.uid);
    } else
      Get.snackbar("error", ingredient + " is already present in your list");
  }

  Future<void> deleteIngredient(int index) async {
    String ingredientToRm = groceryListIngredientsKeys[index];
    groceryListIngredients.removeAt(index);
    groceryListIngredients.refresh();
    groceryListIngredientsKeys.removeAt(index);
    groceryListIngredientsKeys.refresh();
    await API.groceryListIngredient
        .delete(ingredientToRm, groceryList.value.uid);
  }

  Future<void> setIngredientCheckValue(bool value, int index) async {
    groceryListIngredients[index].checked = value;
    groceryListIngredients.refresh();
    await API.groceryListIngredient.update(groceryListIngredients[index],
        groceryListIngredientsKeys[index], groceryList.value.uid);
  }

  Rx<GroceryListModel> groceryList = GroceryListModel().obs;
  RxList<String> groceryListIngredientsKeys = List<String>().obs;
  RxList<GroceryListIngredientModel> groceryListIngredients =
      List<GroceryListIngredientModel>().obs;
  RxBool uploadingProfilePicture = false.obs;
}

final GroceryListStates groceryListStates = Get.put(GroceryListStates());
