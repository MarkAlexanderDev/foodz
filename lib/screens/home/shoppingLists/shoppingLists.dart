import 'package:EasyGroceries/screens/home/contextualArea/CAcard.dart';
import 'package:EasyGroceries/screens/home/contextualArea/contextualAreaStates.dart';
import 'package:EasyGroceries/style/swiperPaginationStyle.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class ShoppingLists extends StatefulWidget {
  @override
  _ShoppingLists createState() => _ShoppingLists();
}

class _ShoppingLists extends State<ShoppingLists> {
  final ShoppingListsStates shoppingListsStates =
  Get.put(ShoppingListsStates());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  }
}
