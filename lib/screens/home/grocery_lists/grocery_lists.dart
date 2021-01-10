import 'package:EasyGroceries/screens/home/grocery_lists/grocery_lists_states.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/color.dart';
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
}

class _GroceryListsItem extends StatelessWidget {
  final GroceryListModel groceryList;

  _GroceryListsItem({@required this.groceryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.toNamed(URL_GROCERY_LIST, arguments: groceryList),
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
