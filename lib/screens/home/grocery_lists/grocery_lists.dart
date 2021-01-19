import 'package:EasyGroceries/extensions/color.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_grocery_list_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/color.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryLists extends StatefulWidget {
  @override
  _GroceryLists createState() => _GroceryLists();
}

class _GroceryLists extends State<GroceryLists> {
  Future _future;

  @override
  void initState() {
    _future = _loadGroceryLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length + 1,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int i) {
                  if (i < snapshot.data.length)
                    return _GroceryListsItem(groceryList: snapshot.data[i]);
                  return _AddGroceryListButton(
                      onClick: () => Get.toNamed(URL_GROCERY_LIST_CREATION));
                });
          } else
            return Loading();
        });
  }

  Future<List<GroceryListModel>> _loadGroceryLists() async {
    final List<GroceryListModel> grocerylists = List<GroceryListModel>();
    final DataSnapshot snap = await API.accountGroceryList
        .getFromUid(FirebaseAuth.instance.currentUser.uid);
    final Map<dynamic, dynamic> groceryListUids = Map();
    if (snap.isNull)
      grocerylists.add(await _createFirstGroceryList());
    else {
      groceryListUids.addAll(snap.value);
      await Future.forEach(groceryListUids.values, (element) async {
        grocerylists
            .add(await API.groceryList.getFromUid(element["groceryListUid"]));
      });
    }
    return grocerylists;
  }

  Future<GroceryListModel> _createFirstGroceryList() async {
    GroceryListModel groceryList = new GroceryListModel();
    groceryList.title = "Monday's grocery list";
    groceryList.description = "All my needs for the week !";
    groceryList.color = mainColor.toHex();
    groceryList.pictureUrl =
        "https://firebasestorage.googleapis.com/v0/b/foodz-2aec5.appspot.com/o/assets%2Fgrocery.png?alt=media&token=d808b0ab-eccf-4bcf-a5ae-36d4dca1b53f";
    await API.groceryList.create(groceryList);
    AccountGroceryListModel accountGroceryList = new AccountGroceryListModel();
    accountGroceryList.groceryListUid = groceryList.uid;
    await API.accountGroceryList.create(accountGroceryList);
    GroceryListIngredientModel groceryListIngredient =
        new GroceryListIngredientModel();
    groceryListIngredient.checked = false;
    await API.groceryListIngredient
        .create("baguette", groceryListIngredient, groceryList.uid);
    return groceryList;
  }
}

class _GroceryListsItem extends StatelessWidget {
  final GroceryListModel groceryList;

  _GroceryListsItem({@required this.groceryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.offNamed(URL_GROCERY_LIST, arguments: groceryList),
        child: Container(
          decoration: BoxDecoration(
              color: hexToColor(groceryList.color),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          groceryList.title,
                          style: textStyleH3Bold,
                          textAlign: TextAlign.center,
                        ),
                        AutoSizeText(groceryList.description,
                            textAlign: TextAlign.center, style: textStyleH4),
                      ]),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: new DecorationImage(
                      image: NetworkImage(groceryList.pictureUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AddGroceryListButton extends StatelessWidget {
  final onClick;

  _AddGroceryListButton({@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GestureDetector(
        onTap: () async {
          await onClick();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Icon(
            Icons.add,
            color: mainColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}
