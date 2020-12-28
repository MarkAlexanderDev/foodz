import 'package:EasyGroceries/screens/home/contextual_area/contextual_area.dart';
import 'package:EasyGroceries/screens/home/grocery_lists/grocery_lists.dart';
import 'package:EasyGroceries/screens/states/app_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final AppStates appStates = Get.put(AppStates());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        shrinkWrap: true,
        children: [ContextualArea(), GroceryLists()],
      ),
    );
  }
}
