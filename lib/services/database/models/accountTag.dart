import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class AccountTag {
  int tagId = -1;
  String createdAt = ".";
  String updatedAt = ".";

  toMap() {
    return {
      "tagId": this.tagId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.tagId = data["tagId"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
