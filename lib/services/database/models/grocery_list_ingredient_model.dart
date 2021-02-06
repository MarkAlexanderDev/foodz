import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class GroceryListIngredientModel {
  bool checked;
  String createdAt;

  toMap() {
    return {
      "checked": this.checked,
      "createdAt": this.createdAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.checked = data["checked"];
    this.createdAt = data["createdAt"];
    return true;
  }
}
