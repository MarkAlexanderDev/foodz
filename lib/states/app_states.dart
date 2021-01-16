import 'package:EasyGroceries/services/dynamic_link.dart';
import 'package:EasyGroceries/services/local_storage/local_storage.dart';
import 'package:EasyGroceries/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  Future<void> initApp() async {
    await dynamicLink.handleDynamicLinks();
    await localStorage.init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  void setIndexBar(int value) {
    indexBar.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  RxInt indexBar = HOME_SCREEN_ID.obs;
  RxBool loading = false.obs;
}

final AppStates appStates = Get.put(AppStates());
