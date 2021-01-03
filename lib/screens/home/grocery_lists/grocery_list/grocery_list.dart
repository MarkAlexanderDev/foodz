import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list/grocery_list_states.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/utils/color.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryList extends StatefulWidget {
  @override
  _GroceryListStreamer createState() => _GroceryListStreamer();
}

class _GroceryListStreamer extends State<GroceryList> {
  final GroceryListModel groceryList = Get.arguments;
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());
  final int groceryListItemCheckId = 0;
  final int groceryListItemIngredientId = 1;
  final SearchBarController _searchBarController = SearchBarController();
  Stream _stream;

  @override
  void initState() {
    groceryListStates.currentGroceryList.addAll(groceryList.toMap());
    _stream = groceryListStates.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      hexToColor(groceryListStates.currentGroceryList["color"]),
                  title: AutoSizeText(
                    groceryListStates.currentGroceryList["title"],
                    style: textStyleH3Bold,
                  ),
                  actions: [
                    Icon(Icons.create),
                    Container(width: 20),
                  ],
                  centerTitle: true,
                ),
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                groceryListStates.groceryListIngredients.length,
                            itemBuilder: (BuildContext context, int i) {
                              return _getGroceryListItem(i);
                            })),
                        Container(
                          height: 150,
                          child: SearchBar(
                            onSearch: API.ingredient.searchIngredient,
                            searchBarController: _searchBarController,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 2,
                            onItemFound: (ingredient, int index) {
                              if (ingredient == null) return null;
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                )),
                                child: ListTile(
                                  title: Text(ingredient["title"]),
                                  onTap: () async {
                                    _addIngredient(ingredient);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ))));
          } else
            return Loading();
        });
  }

  _getGroceryListItem(index) {
    return Row(
      children: [
        AutoSizeText(groceryListStates.groceryListIngredients[index]
            [groceryListItemIngredientId]["title"]),
        Expanded(child: Container()),
        Obx(() => Checkbox(
              value: groceryListStates.groceryListIngredients[index]
                  [groceryListItemCheckId],
              onChanged: (bool value) =>
                  {groceryListStates.setIngredientCheckValue(value, index)},
            )),
      ],
    );
  }

  _addIngredient(ingredient) async {
    GroceryListIngredientModel groceryListIngredient =
        new GroceryListIngredientModel();
    groceryListIngredient.ingredientId = ingredient["id"];
    groceryListIngredient.checked = false;
    await API.groceryListIngredient
        .create(groceryListIngredient, groceryList.uid);
  }
}
