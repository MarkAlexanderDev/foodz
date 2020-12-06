import 'package:EasyGroceries/screens/profile/profileStates.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/profilePicture.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                  onTap: () async {
                    profileStates.setPictureUrl(await getImage(context,
                        !profileStates.pictureUrl.value.isNullOrBlank));
                  },
                  child: Obx(() => ProfilePicture(
                        height: 100,
                        width: 100,
                        pictureUrl: profileStates.pictureUrl.value,
                        editMode: true,
                        onEdit: () async {
                          profileStates.setPictureUrl(await getImage(context,
                              !profileStates.pictureUrl.value.isNullOrBlank));
                        },
                      ))),
              Container(height: 20),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                style: textStyleH1,
                decoration: getStandardInputDecoration("name", ""),
                initialValue: profileStates.name.value,
                onChanged: (value) {
                  profileStates.setName(value);
                },
              ),
              Container(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: ConfirmButton(
          onClick: () async {
            await profileStates.saveData();
            Get.toNamed(URL_HOME);
          },
        ));
  }
}
