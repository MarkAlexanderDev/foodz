import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_model.dart';
import 'package:EasyGroceries/services/dynamic_link.dart';
import 'package:EasyGroceries/services/local_storage/local_storage.dart';
import 'package:EasyGroceries/widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  Future<bool> initApp() async {
    await dynamicLink.handleDynamicLinks();
    await localStorage.init();
    if (!FirebaseAuth.instance.currentUser.isNull) {
      AccountModel account =
          await API.account.getFromUid(FirebaseAuth.instance.currentUser.uid);
      currentAccount.addAll(account.toMap());
    }
    return true;
  }

  void setIndexBar(int value) {
    indexBar.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void setCurrentAccount(AccountModel value) {
    currentAccount.addAll(value.toMap());
  }

  RxInt indexBar = HOME_SCREEN_ID.obs;
  RxMap currentAccount = {}.obs;
  RxBool loading = false.obs;
}
