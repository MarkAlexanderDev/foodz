import 'dart:convert';

import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccount {
  DatabaseReference get() {
    return databaseReference.child(endpointAccount);
  }

  create(Account account) async {
    var id = get().child(account.uid);
    await id.set(account.toMap());
    return id;
  }

  update(Account account) async {
    var id = get().child(account.uid);
    await id.update(account.toMap());
    return id;
  }

  getFromUid(uid) async {
    Account account = new Account();
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value != null) account.fromJson(snap.value);
    return account;
  }

  getInMap(uid) async {
    Account entity = await getFromUid(uid);
    Map<String, dynamic> map = json.decode(entity.toJson());
    return map;
  }

  exist(uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return false;
    return true;
  }
}

Account fromMapToAccount(Map mapAccount) {
  Account account = new Account();
  account.uid = mapAccount["uid"];
  account.firstName = mapAccount["firstName"];
  account.lastName = mapAccount["lastName"];
  account.onboardingFlag = mapAccount["onboardingFlag"];
  account.pictureUrl = mapAccount["pictureUrl"];
  account.createdAt = mapAccount["createdAt"];
  account.updatedAt = mapAccount["updatedAt"];
  return account;
}
