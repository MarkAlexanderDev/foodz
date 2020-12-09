import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:EasyGroceries/screens/onboarding/onboarding.dart';

class Account {
  String uid = "";
  String firstName;
  String lastName;
  String pictureUrl;
  int onboardingFlag = ONBOARDING_STEP_ID_ALLERGIC;
  String createdAt = ".";
  String updatedAt = ".";

  toMap() {
    return {
      "uid": this.uid,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "pictureUrl": this.pictureUrl,
      "onboardingFlag": this.onboardingFlag,
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
    this.firstName = data["firstName"];
    this.lastName = data["lastName"];
    this.pictureUrl = data["pictureUrl"];
    this.onboardingFlag = data["onboardingFlag"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
