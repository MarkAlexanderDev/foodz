import 'dart:collection';

import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_tag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccountTag {
  DatabaseReference get(String path) {
    return databaseReference.child(path);
  }

  create(AccountTag accountTag, String path) async {
    var id = get(path)
        .child(FirebaseAuth.instance.currentUser.uid)
        .push()
        .set(accountTag.toMap());
    return id;
  }

  delete(String path, String uid) async {
    await get(path)
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(uid)
        .remove();
  }

  getFromUid(uid, String path) async {
    final DataSnapshot snap = await get(path).child(uid).once();
    if (snap.value == null) return HashMap();
    return snap.value;
  }
}
