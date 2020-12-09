import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class Account {
  String uid = "";
  String firstName;
  String lastName;
  String pictureUrl;
  String createdAt = ".";
  String updatedAt = ".";

  toMap() {
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "pictureUrl": this.pictureUrl,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.uid = FirebaseAuth.instance.currentUser.uid;
    this.firstName = data["firstName"];
    this.lastName = data["lastName"];
    this.pictureUrl = data["pictureUrl"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
