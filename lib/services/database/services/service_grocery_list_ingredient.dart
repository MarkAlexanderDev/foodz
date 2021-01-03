import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceGroceryListIngredient {
  DatabaseReference get() {
    return databaseReference.child(endpointGroceryListIngredient);
  }

  Future<void> create(
      GroceryListIngredientModel groceryListIngredient, String uid) async {
    await get().child(uid).push().set(groceryListIngredient.toMap());
  }

  Future<void> update(GroceryListIngredientModel groceryListIngredient,
      ingredientUid, listUid) async {
    await get()
        .child(listUid)
        .child(ingredientUid)
        .update(groceryListIngredient.toMap());
  }

  Future<dynamic> getFromUid(String uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return null;
    return snap;
  }
}
