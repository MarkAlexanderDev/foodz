import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class GroceryListIngredientModel {
  bool checked;
  String createdAt = "";
  String updatedAt = "";

  toMap() {
    return {
      "checked": this.checked,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.checked = data["checked"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
