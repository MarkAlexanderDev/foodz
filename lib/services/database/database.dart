import 'package:EasyGroceries/services/database/services/service_account.dart';
import 'package:EasyGroceries/services/database/services/service_account_grocery_list.dart';
import 'package:EasyGroceries/services/database/services/service_account_tag.dart';
import 'package:EasyGroceries/services/database/services/service_grocery_list.dart';
import 'package:EasyGroceries/services/database/services/service_tag.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();
FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class API {
  static final account = new ServiceAccount();
  static final tag = new ServiceTag();
  static final accountTag = new ServiceAccountTag();
  static final groceryList = new ServiceGroceryList();
  static final accountGroceryList = new ServiceAccountGroceryList();
}
