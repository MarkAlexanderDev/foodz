import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class AccountGroceryListModel {
  String groceryListUid;
  String createdAt = ".";
  String updatedAt = ".";

  toMap() {
    return {
      "groceryListUid": this.groceryListUid,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.groceryListUid = data["groceryListUid"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
