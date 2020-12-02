import 'package:EasyGroceries/screens/profile/profileStates.dart';
import 'package:EasyGroceries/screens/redirections.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/utils/button.dart';
import 'package:EasyGroceries/utils/loading.dart';
import 'package:EasyGroceries/utils/profilePicture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final ProfileStates profileStates = Get.put(ProfileStates());
  Future<bool> _future;

  @override
  void initState() {
    profileStates.setLoading(false);
    _future = profileStates.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && !profileStates.loading.value)
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: AutoSizeText(
                        "MY PROFILE",
                        style: textStyleH1,
                      ),
                    ),
                    Container(height: 20),
                    ProfilePicture(height: 100, width: 100),
                    Container(height: 20),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      style: textStyleH1,
                      decoration: getStandardInputDecoration("name", ""),
                      initialValue: profileStates.name.value,
                      onChanged: (value) {},
                    ),
                    Container(height: 20),
                  ],
                ),
              ),
              bottomNavigationBar: ConfirmButton(
                onClick: () async {
                  profileStates.setLoading(true);
                  await profileStates.saveData();
                  Get.to(Redirections());
                },
              ));
        else
          return Loading();
      },
    );
  }
}
