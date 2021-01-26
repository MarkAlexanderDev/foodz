import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class AllergyModel {
  String name = "";
  bool active = false;
  bool wasActivated = false;
  bool isVegan = false;
  bool isVegetarian = false;

  AllergyModel({this.name, this.isVegan, this.isVegetarian});

  toMap() {
    return {
      "isVegan": this.isVegan,
      "isVegetarian": this.isVegetarian,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.isVegan = data["isVegan"];
    this.isVegetarian = data["isVegetarian"];
    return true;
  }
}
