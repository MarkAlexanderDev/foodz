import 'package:EasyGroceries/extensions/color.dart';
import 'package:EasyGroceries/services/dynamic_link.dart';
import 'package:EasyGroceries/states/app_states.dart';
import 'package:EasyGroceries/states/grocery_list_states.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/color.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:EasyGroceries/widgets/section_title.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class GroceryListOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Center(
                child: AutoSizeText(
                  "GROCERY LIST OPTIONS",
                  style: textStyleH1,
                ),
              ),
              Container(height: 20),
              GestureDetector(
                  onTap: () async {
                    await _onEditPicture(context);
                  },
                  child: Obx(() => ProfilePicture(
                        height: 100,
                        width: 100,
                        name: groceryListStates.groceryList.value.title,
                        pictureUrl:
                            groceryListStates.groceryList.value.pictureUrl,
                        editMode: true,
                        onEdit: () async {
                          await _onEditPicture(context);
                        },
                      ))),
              Container(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  style: textStyleH1,
                  textAlign: TextAlign.center,
                  decoration: getStandardInputDecoration("name", ""),
                  initialValue: groceryListStates.groceryList.value.title,
                  onChanged: (value) {
                    groceryListStates.groceryList.value.title = value;
                  },
                ),
              ),
              Container(height: 20),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                style: textStyleH2,
                decoration: getStandardInputDecoration("description", ""),
                initialValue: groceryListStates.groceryList.value.description,
                onChanged: (value) {
                  groceryListStates.groceryList.value.description = value;
                },
              ),
              Container(height: 20),
              SectionTitle(
                  icon: Icons.accessibility_outlined,
                  text: "WHO CAN ACCESS THIS LIST"),
              Container(height: 10),
              OutlineButton(
                  onPressed: () async {
                    await Share.share(
                        'Hello! I would like to share with you my grocery list from Foodz : ' +
                            await dynamicLink.createGroceryListInvitationLink(
                                groceryListStates.groceryList.value.uid));
                  },
                  child: AutoSizeText("SHARE")),
              BlockPicker(
                pickerColor:
                    hexToColor(groceryListStates.groceryList.value.color),
                onColorChanged: (value) =>
                    groceryListStates.groceryList.value.color = value.toHex(),
                availableColors: [mainColor, secondaryColor, accentColor],
              ),
            ],
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ConfirmButton(
        enabled: !appStates.uploadingProfilePicture.value,
        onClick: () async {
          await groceryListStates.updateGroceryList();
          Get.toNamed(URL_GROCERY_LIST,
              arguments: groceryListStates.groceryList.value);
        },
      ),
    );
  }

  Future<void> _onEditPicture(context) async {
    final String imgPath = await getImage(
        context, !groceryListStates.groceryList.value.pictureUrl.isNullOrBlank);
    groceryListStates.groceryList.update((groceryList) {
      if (!imgPath.isNull) groceryList.pictureUrl = imgPath;
    });
  }
}
