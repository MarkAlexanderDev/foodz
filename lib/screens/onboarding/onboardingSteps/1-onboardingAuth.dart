import 'package:EasyGroceries/services/auth.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account.dart';
import 'package:EasyGroceries/utils/string.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlineButton(
        onPressed: () async {
          await _signIn(await authService.googleSignIn());
        },
        child: AutoSizeText("Google Sign in"),
      ),
    );
  }

  Future<void> _signIn(User firebaseUser) async {
    if (firebaseUser == null)
      Get.snackbar("Error", "something went wrong");
    else {
      Account account = new Account();
      account.uid = FirebaseAuth.instance.currentUser.uid;
      account.firstName = fullNameToFirstName(firebaseUser.displayName);
      account.lastName = fullNameToLastName(firebaseUser.displayName);
      account.pictureUrl = firebaseUser.photoURL;
      account.createdAt = DateTime.now().toUtc().toString();
      account.updatedAt = DateTime.now().toUtc().toString();
      await API.account.create(account);
    }
  }
}
