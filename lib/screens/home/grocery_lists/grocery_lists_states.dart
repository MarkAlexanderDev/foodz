import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_grocery_list_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class GroceryListsStates extends GetxController {
  static GroceryListsStates get to => Get.find();

  Future<List<GroceryListModel>> getData() async {
    final List<GroceryListModel> grocerylists = List<GroceryListModel>();
    final DataSnapshot snap = await API.accountGroceryList
        .getFromUid(FirebaseAuth.instance.currentUser.uid);
    final Map<dynamic, dynamic> groceryListUids = snap.value;
    if (groceryListUids == null)
      grocerylists.add(await _createFirstGroceryList());
    else
      await Future.forEach(groceryListUids.values, (element) async {
        grocerylists
            .add(await API.groceryList.getFromUid(element["groceryListUid"]));
      });
    return grocerylists;
  }

  Future<GroceryListModel> _createFirstGroceryList() async {
    GroceryListModel groceryList = new GroceryListModel();
    groceryList.title = "Monday's grocery list";
    groceryList.description = "All my needs for the week !";
    groceryList.color = mainColor.toString();
    groceryList.pictureUrl =
        "https://firebasestorage.googleapis.com/v0/b/foodz-2aec5.appspot.com/o/assets%2Fgrocery.png?alt=media&token=d808b0ab-eccf-4bcf-a5ae-36d4dca1b53f";
    await API.groceryList.create(groceryList);
    AccountGroceryListModel accountGroceryList = new AccountGroceryListModel();
    accountGroceryList.groceryListUid = groceryList.uid;
    await API.accountGroceryList.create(accountGroceryList);
    return groceryList;
  }
}
