import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class IngredientModel {
  String title = "";
  String pictureUrl = "";
  int saisonStart = 0;
  int saisonEnd = 0;
  String createdAt = ".";
  String updatedAt = ".";

  toMap() {
    return {
      "title": this.title,
      "pictureUrl": this.pictureUrl,
      "saisonStart": this.saisonStart,
      "saisonEnd": this.saisonEnd,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.title = data["title"];
    this.pictureUrl = data["pictureUrl"];
    this.saisonStart = data["saisonStart"];
    this.saisonEnd = data["saisonEnd"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
