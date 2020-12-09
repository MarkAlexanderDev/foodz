import 'package:EasyGroceries/screens/onboarding/onboardingStates.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account.dart';
import 'package:EasyGroceries/services/localStorage/localStorage.dart';
import 'package:EasyGroceries/widgets/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();
  final OnboardingStates onboardingStates = Get.put(OnboardingStates());

  Future<bool> getData() async {
    await localStorage.init();
    if (!FirebaseAuth.instance.currentUser.isNull) {
      Account account =
          await API.account.getFromUid(FirebaseAuth.instance.currentUser.uid);
      print("test");
      currentAccount.addAll(account.toMap());
      onboardingStates.setOnboardingStep(account.onboardingFlag);
    }
    return true;
  }

  void setIndexBar(int value) {
    indexBar.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void setCurrentAccount(Account value) {
    currentAccount.addAll(value.toMap());
  }

  RxInt indexBar = HOME_SCREEN_ID.obs;
  RxMap currentAccount = {}.obs;
  RxBool loading = false.obs;
}
