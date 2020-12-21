import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:EasyGroceries/services/database/services/serviceAccountTag.dart';
import 'package:EasyGroceries/services/database/services/serviceTag.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();
FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class API {
  static final account = new ServiceAccount();
  static final tag = new ServiceTag();
  static final accountTag = new ServiceAccountTag();
}
