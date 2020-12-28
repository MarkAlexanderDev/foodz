import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_grocery_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccountGroceryList {
  DatabaseReference get() {
    return databaseReference.child(endpointAccountGroceryList);
  }

  Future<void> create(AccountGroceryListModel accountGroceryList) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .push()
        .set(accountGroceryList.toMap());
  }

  delete(String uid) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(uid)
        .remove();
  }

  Future<dynamic> getFromUid(String uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return null;
    return snap;
  }
}
