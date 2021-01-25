import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class AccountGroceryListModel {
  String groceryListUid;
  bool owner;

  toMap() {
    return {
      "owner": this.owner,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.groceryListUid = data["groceryListUid"];
    this.owner = data["owner"];
    return true;
  }
}
