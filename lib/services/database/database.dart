import 'package:EasyGroceries/services/database/services/service_account.dart';
import 'package:EasyGroceries/services/database/services/service_account_grocery_list.dart';
import 'package:EasyGroceries/services/database/services/service_account_tag.dart';
import 'package:EasyGroceries/services/database/services/service_grocery_list.dart';
import 'package:EasyGroceries/services/database/services/service_grocery_list_ingredient.dart';
import 'package:EasyGroceries/services/database/services/service_ingredient.dart';
import 'package:EasyGroceries/services/database/services/service_tag.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();
FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class API {
  static final account = ServiceAccount();
  static final tag = ServiceTag();
  static final accountTag = ServiceAccountTag();
  static final groceryList = ServiceGroceryList();
  static final accountGroceryList = ServiceAccountGroceryList();
  static final groceryListIngredient = ServiceGroceryListIngredient();
  static final ingredient = ServiceIngredient();
}
