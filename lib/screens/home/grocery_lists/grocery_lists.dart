import 'package:EasyGroceries/screens/home/grocery_lists/grocery_lists_states.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryLists extends StatefulWidget {
  @override
  _GroceryLists createState() => _GroceryLists();
}

class _GroceryLists extends State<GroceryLists> {
  final GroceryListsStates groceryListsStates = Get.put(GroceryListsStates());
  Future _future;

  @override
  void initState() {
    _future = groceryListsStates.getData();
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
                itemCount: snapshot.data.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int i) {
                  return _GroceryListsItem(groceryList: snapshot.data[i]);
                });
          } else
            return Loading();
        });
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
        onTap: () => Get.toNamed(URL_GROCERY_LIST),
        child: Container(
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  AutoSizeText(
                    groceryList.title,
                    style: textStyleH3Bold,
                    textAlign: TextAlign.center,
                  ),
                  AutoSizeText(groceryList.description,
                      textAlign: TextAlign.center, style: textStyleH4),
                ]),
              ),
              Flexible(
                flex: 2,
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
