import 'package:EasyGroceries/extensions/color.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_model.dart';
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
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:EasyGroceries/widgets/section_title.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class GroceryListOption extends StatefulWidget {
  @override
  _GroceryListOption createState() => _GroceryListOption();
}

class _GroceryListOption extends State<GroceryListOption> {
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());
  Future _future;

  @override
  void initState() {
    _future = _getMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
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
                                pictureUrl: groceryListStates
                                    .groceryList.value.pictureUrl,
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
                          initialValue:
                              groceryListStates.groceryList.value.title,
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
                        decoration:
                            getStandardInputDecoration("description", ""),
                        initialValue:
                            groceryListStates.groceryList.value.description,
                        onChanged: (value) {
                          groceryListStates.groceryList.value.description =
                              value;
                        },
                      ),
                      Container(height: 20),
                      _Members(
                          members: snapshot.data,
                          groceryListUid:
                              groceryListStates.groceryList.value.uid),
                      Container(height: 10),
                      BlockPicker(
                        pickerColor: hexToColor(
                            groceryListStates.groceryList.value.color),
                        onColorChanged: (value) => groceryListStates
                            .groceryList.value.color = value.toHex(),
                        availableColors: [
                          mainColor,
                          secondaryColor,
                          accentColor
                        ],
                      ),
                    ],
                  ))),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: ConfirmButton(
                enabled: !appStates.uploadingProfilePicture.value,
                onClick: () async {
                  await groceryListStates.updateGroceryList();
                  Get.toNamed(URL_GROCERY_LIST,
                      arguments: groceryListStates.groceryList.value);
                },
              ),
            );
          else
            return Container(color: Colors.white, child: Loading());
        });
  }

  Future<List<AccountModel>> _getMembers() async {
    final List<AccountModel> accounts = List<AccountModel>();
    final DataSnapshot snap = await API.accountGroceryList
        .getFromGroceryListUid(groceryListStates.groceryList.value.uid);
    final Map<dynamic, dynamic> accountGroceryLists = Map();
    accountGroceryLists.addAll(snap.value);
    await Future.forEach(accountGroceryLists.keys, (element) async {
      accounts.add(await API.account.getFromUid(element));
    });
    return accounts;
  }

  Future<void> _onEditPicture(context) async {
    final String imgPath = await getImage(
        context, !groceryListStates.groceryList.value.pictureUrl.isNullOrBlank);
    groceryListStates.groceryList.update((groceryList) {
      if (!imgPath.isNull) groceryList.pictureUrl = imgPath;
    });
  }
}

class _Members extends StatelessWidget {
  final List<AccountModel> members;
  final String groceryListUid;

  _Members({@required this.members, @required this.groceryListUid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SectionTitle(
                icon: Icons.accessibility_outlined,
                text: "WHO CAN ACCESS THIS LIST"),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () async {
                await Share.share(
                    'Hello! I would like to share with you my grocery list from Foodz : ' +
                        await dynamicLink
                            .createGroceryListInvitationLink(groceryListUid));
              },
              child: Icon(Icons.share),
            )
          ],
        ),
        Container(height: 10),
        ListView.builder(
            shrinkWrap: true,
            itemCount: members.length,
            itemBuilder: (BuildContext context, int i) {
              return Center(
                child: AutoSizeText(
                    members[i].uid == FirebaseAuth.instance.currentUser.uid
                        ? "You"
                        : members[i].name),
              );
            })
      ],
    );
  }
}
