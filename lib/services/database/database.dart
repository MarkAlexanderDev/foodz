import 'package:EasyGroceries/services/database/services/serviceAccount.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();

class API {
  static final account = new ServiceAccount();
}
