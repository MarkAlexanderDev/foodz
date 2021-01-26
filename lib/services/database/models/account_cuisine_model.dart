import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class AccountCuisineModel {
  String name = "";

  toMap() {
    return {
      "name": this.name,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.name = data["name"];
    return true;
  }
}
