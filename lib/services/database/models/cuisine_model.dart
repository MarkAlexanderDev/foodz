import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class CuisineModel {
  String name = "";
  bool active = false;
  bool wasActivated = false;
  String description = "";

  CuisineModel({this.name, this.description});

  toMap() {
    return {
      "description": this.description,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.description = data["description"];
    return true;
  }
}
