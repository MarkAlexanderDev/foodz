import 'dart:convert';

import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccount {
  DatabaseReference get() {
    return databaseReference.child(endpointAccount);
  }

  create(AccountModel account) async {
    var id = get().child(account.uid);
    await id.set(account.toMap());
    return id;
  }

  update(AccountModel account) async {
    var id = get().child(account.uid);
    await id.update(account.toMap());
    return id;
  }

  getFromUid(uid) async {
    AccountModel account = new AccountModel();
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value != null) account.fromJson(snap.value);
    return account;
  }

  getInMap(uid) async {
    AccountModel entity = await getFromUid(uid);
    Map<String, dynamic> map = json.decode(entity.toJson());
    return map;
  }

  exist(uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return false;
    return true;
  }
}

AccountModel fromMapToAccount(Map mapAccount) {
  AccountModel account = new AccountModel();
  account.uid = mapAccount["uid"];
  account.firstName = mapAccount["firstName"];
  account.lastName = mapAccount["lastName"];
  account.cookingExperience = mapAccount["cookingExperience"];
  account.peopleNumber = mapAccount["peopleNumber"];
  account.onboardingFlag = mapAccount["onboardingFlag"];
  account.pictureUrl = mapAccount["pictureUrl"];
  account.createdAt = mapAccount["createdAt"];
  account.updatedAt = mapAccount["updatedAt"];
  return account;
}
