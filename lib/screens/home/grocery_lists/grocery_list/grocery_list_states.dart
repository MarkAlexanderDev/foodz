import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  static GroceryListStates get to => Get.find();

  Stream streamGroceryList() async* {
    databaseReference
        .child(endpointGroceryListIngredient)
        .child(groceryList.value.uid)
        .onValue
        .listen((event) async {
      groceryListIngredientsTmp.assignAll(groceryListIngredients);
      isFillingList.value = true;
      groceryListIngredients.clear();
      final Map groceryListIngredientIds = Map();
      groceryListIngredientIds.addAll(event.snapshot.value);
      await Future.forEach(groceryListIngredientIds.entries, (element) async {
        groceryListIngredients.add([
          element.value["checked"],
          await API.ingredient.getIngredient(element.value["ingredientUid"]),
          element.key
        ]);
      });
      isFillingList.value = false;
    });
    yield true;
  }

  Future<void> deleteIngredient(int index) async {
    await API.groceryListIngredient
        .delete(groceryListIngredients[index][2], groceryList.value.uid);
  }

  Future<void> setIngredientCheckValue(bool value, int index) async {
    GroceryListIngredientModel groceryListIngredient =
        new GroceryListIngredientModel();
    groceryListIngredient.checked = value;
    groceryListIngredient.ingredientId = groceryListIngredients[index][1]["id"];
    await API.groceryListIngredient.update(groceryListIngredient,
        groceryListIngredients[index][2], groceryList.value.uid);
  }

  Future<bool> getOptionData() async {
    final accountGroceryLists = await API.accountGroceryList
        .getFromGroceryListUid(groceryList.value.uid);
    await Future.forEach(accountGroceryLists.value.entries, (element) async {
      if (element.key != FirebaseAuth.instance.currentUser.uid)
        owners.add(await API.account.getFromUid(element.key));
    });
    groceryListPictureUrl.value = groceryList.value.pictureUrl;
    return true;
  }

  Future<bool> setOptionData() async {
    await API.groceryList.update(groceryList.value);
    return true;
  }

  void setGroceryListPictureUrl(String value) {
    if (value != null) {
      groceryListPictureUrl.value = value;
      groceryList.value.pictureUrl = value;
    }
  }

  Rx<GroceryListModel> groceryList = GroceryListModel().obs;

  RxList groceryListIngredients = [].obs;
  RxList groceryListIngredientsTmp = [].obs;
  RxBool isFillingList = false.obs;

  RxList owners = [].obs;
  RxString groceryListPictureUrl = "".obs;
  RxBool isLoading = false.obs;
}

final GroceryListStates groceryListStates = Get.put(GroceryListStates());
