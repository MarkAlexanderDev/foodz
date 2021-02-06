import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class GroceryListModel {
  String uid = "";
  String title;
  String description;
  String pictureUrl;
  String color;
  String createdAt = ".";
  String updatedAt = ".";

  GroceryListModel();

  toMap() {
    return {
      "title": this.title,
      "description": this.description,
      "pictureUrl": this.pictureUrl,
      "color": this.color,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.uid = data["uid"];
    this.title = data["title"];
    this.description = data["description"];
    this.pictureUrl = data["pictureUrl"];
    this.color = data["color"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
