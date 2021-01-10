import 'package:EasyGroceries/extensions/color.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list/grocery_list_states.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_grocery_list_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/color.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class GroceryListCreation extends StatefulWidget {
  @override
  _GroceryListCreation createState() => _GroceryListCreation();
}

class _GroceryListCreation extends State<GroceryListCreation> {
  final AppStates appStates = Get.put(AppStates());
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());

  @override
  void initState() {
    groceryListStates.currentGroceryList.value = GroceryListModel();
    groceryListStates.currentGroceryList.value.title = "New grocery list";
    groceryListStates.currentGroceryList.value.description = "New description";
    groceryListStates.currentGroceryList.value.color = mainColor.toHex();
    groceryListStates.currentGroceryList.value.pictureUrl =
        "https://firebasestorage.googleapis.com/v0/b/foodz-2aec5.appspot.com/o/assets%2Fgrocery.png?alt=media&token=d808b0ab-eccf-4bcf-a5ae-36d4dca1b53f";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 60),
          child: Obx(() => AppBar(
            backgroundColor:
                hexToColor(groceryListStates.currentGroceryList.value.color),
            title: AutoSizeText(
              "Grocery list creation",
              style: textStyleH3Bold,
            ),
            centerTitle: true,
          ))),
      bottomNavigationBar: ConfirmButton(onClick: () async {
        appStates.setLoading(true);
        await _createGroceryList();
        Get.toNamed(URL_GROCERY_LIST,
            arguments: groceryListStates.currentGroceryList.value);
        appStates.setLoading(false);
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                groceryListStates.currentGroceryList.value.pictureUrl =
                    await getImage(
                        context,
                        !groceryListStates
                            .currentGroceryList.value.pictureUrl.isNullOrBlank);
              },
              child: Obx(() => ProfilePicture(
                    name: groceryListStates.currentGroceryList.value.title,
                    pictureUrl:
                        groceryListStates.currentGroceryList.value.pictureUrl,
                    editMode: true,
                    height: 100,
                    width: 100,
                    onEdit: () async {
                      groceryListStates.currentGroceryList.value.pictureUrl =
                          await getImage(
                              context,
                              !groceryListStates.currentGroceryList.value
                                  .pictureUrl.isNullOrBlank);
                    },
                  )),
            ),
            Container(
              width: appWidth,
              height: appHeight * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How should we name your new list?",
                  style: textStyleH2,
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: textStyleH2,
              decoration: getStandardInputDecoration("", ""),
              initialValue: groceryListStates.currentGroceryList.value.title,
              onChanged: (value) {
                groceryListStates.currentGroceryList.value.title = value;
              },
            ),
            Container(
              width: appWidth,
              height: appHeight * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How would you describe it?",
                  style: textStyleH2,
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: textStyleH2,
              decoration: getStandardInputDecoration("", ""),
              initialValue:
                  groceryListStates.currentGroceryList.value.description,
              onChanged: (value) {
                groceryListStates.currentGroceryList.value.description = value;
              },
            ),
            Container(height: 20),
            BlockPicker(
              pickerColor:
                  hexToColor(groceryListStates.currentGroceryList.value.color),
              onColorChanged: (value) => groceryListStates
                  .currentGroceryList.value.color = value.toHex(),
              availableColors: [mainColor, secondaryColor, accentColor],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _createGroceryList() async {
    await API.groceryList.create(groceryListStates.currentGroceryList.value);
    AccountGroceryListModel accountGroceryList = new AccountGroceryListModel();
    accountGroceryList.groceryListUid =
        groceryListStates.currentGroceryList.value.uid;
    await API.accountGroceryList.create(accountGroceryList);
    GroceryListIngredientModel groceryListIngredient =
        new GroceryListIngredientModel();
    groceryListIngredient.checked = false;
    groceryListIngredient.ingredientId = 0;
    await API.groceryListIngredient.create(
        groceryListIngredient, groceryListStates.currentGroceryList.value.uid);
  }
}
