import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountStates extends GetxController {
  static AccountStates get to => Get.find();

  Future<void> createAccount(AccountModel newAccount) async {
    account.value = await API.account.create(newAccount);
  }

  Future<void> getAccount() async {
    if (!FirebaseAuth.instance.currentUser.isNullOrBlank)
      account.value =
          await API.account.getFromUid(FirebaseAuth.instance.currentUser.uid);
  }

  Future<void> updateAccount() async {
    await API.account.update(account.value);
  }

  Future<bool> doesAccountExist() async {
    return await API.account.exist(FirebaseAuth.instance.currentUser.uid);
  }

  String getCookingExperienceConverted(int value) {
    return COOKING_EXPERIENCE_IDS[value];
  }

  Rx<AccountModel> account = AccountModel().obs;
}
