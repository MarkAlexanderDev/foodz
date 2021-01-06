import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list/grocery_list_states.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/utils/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryListOption extends StatefulWidget {
  @override
  _GroceryListOption createState() => _GroceryListOption();
}

class _GroceryListOption extends State<GroceryListOption> {
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              hexToColor(groceryListStates.currentGroceryList["color"]),
          title: AutoSizeText(
            groceryListStates.currentGroceryList["title"] + " options",
            style: textStyleH3Bold,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Column(
              children: [Center(child: AutoSizeText(""))],
            ))));
  }
}
