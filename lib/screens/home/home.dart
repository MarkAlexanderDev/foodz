import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/CAcard.dart';
import 'package:EasyGroceries/screens/home/homeStates.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/swiperPaginationStyle.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/utils/loading.dart';
import 'package:EasyGroceries/utils/profilePicture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final HomeStates homeStates = Get.put(HomeStates());
  Future<bool> _future;

  @override
  void initState() {
    _future = homeStates.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData)
          return Scaffold(
              body: Column(
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: _getProfileSection(),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: _getCaSection(),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: _getShoppingListSection(),
              )
            ],
          ));
        else
          return Loading();
      },
    );
  }

  _getProfileSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child: ProfilePicture(
              height: 100,
              width: 100,
            ),
          ),
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 1,
              child: AutoSizeText("Hey there ! ✌️", style: textStyleH1))
        ],
      ),
    );
  }

  _getCaSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Swiper(
        autoplay: true,
        autoplayDelay: 10000,
        duration: 500,
        itemCount: homeStates.caSlides.length,
        outer: true,
        loop: true,
        pagination: getCustomSwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return CAcard(
            slide: homeStates.caSlides[index],
          );
        },
      ),
    );
  }

  _getShoppingListSection() {
    return Container(
      width: appWidth,
      color: mainColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          "MY NEXT GROCERY SHOPPING LIST",
          style: textStyleH3Bold,
          maxLines: 1,
        ),
      ),
    );
  }
}
