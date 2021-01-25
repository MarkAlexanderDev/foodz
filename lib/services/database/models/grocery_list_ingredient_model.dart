import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class GroceryListIngredientModel {
  bool checked;

  toMap() {
    return {
      "checked": this.checked,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.checked = data["checked"];
    return true;
  }
}
