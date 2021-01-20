import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceTag {
  DatabaseReference get() {
    return databaseReference.child(endpointTag);
  }

  Future<List> getTags(String path) async {
    final DataSnapshot snap = await get().child(path).once();
    return snap.value;
  }
}
