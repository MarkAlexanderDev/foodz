import 'dart:convert';

import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceGroceryList {
  DatabaseReference get() {
    return databaseReference.child(endpointGroceryList);
  }

  create(GroceryListModel groceryList) async {
    DatabaseReference id = get().push();
    groceryList.uid = id.key;
    await id.set(groceryList.toMap());
    return id;
  }

  update(GroceryListModel groceryList) async {
    var id = get().child(groceryList.uid);
    await id.update(groceryList.toMap());
    return id;
  }

  Future<GroceryListModel> getFromUid(uid) async {
    GroceryListModel groceryList = new GroceryListModel();
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value != null) groceryList.fromJson(snap.value);
    return groceryList;
  }

  getInMap(uid) async {
    GroceryListModel entity = await getFromUid(uid);
    Map<String, dynamic> map = json.decode(entity.toJson());
    return map;
  }
}

GroceryListModel fromMapToGroceryList(Map mapGroceryList) {
  GroceryListModel groceryList = new GroceryListModel();
  groceryList.uid = mapGroceryList["uid"];
  groceryList.title = mapGroceryList["title"];
  groceryList.description = mapGroceryList["description"];
  groceryList.color = mapGroceryList["color"];
  groceryList.pictureUrl = mapGroceryList["pictureUrl"];
  groceryList.createdAt = mapGroceryList["createdAt"];
  groceryList.updatedAt = mapGroceryList["updatedAt"];
  return groceryList;
}
