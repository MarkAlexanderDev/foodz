import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/contextualArea/consts.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeOfTheWeek extends StatelessWidget {
  final slide = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightGrey,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            _getImage(),
            _getTitle(),
            _getIngredientsList(),
          ],
        ));
  }

  _getImage() {
    return Container(
      height: 200,
      width: appWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(slide[KEY_RECIPE_OF_THE_WEEK_IMG]),
            fit: BoxFit.cover),
      ),
    );
  }

  _getTitle() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  "RECIPE OF THE WEEK",
                  style: textStyleH1BoldUnderLine,
                ),
                Container(
                  height: 5,
                ),
                AutoSizeText(
                  slide[KEY_RECIPE_OF_THE_WEEK_LABEL],
                  style: textStyleH1Green,
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                    child: AutoSizeText(
                        double.parse(slide[KEY_RECIPE_OF_THE_WEEK_CALORIES])
                                .round()
                                .toString() +
                            " kCal"),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _getIngredientsList() {
    return Container(
      width: appWidth,
      color: lightGrey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            AutoSizeText(
              "Ingredients",
              style: textStyleH2BoldUnderLine,
            ),
            Container(height: 20),
            GridView.count(
              shrinkWrap: true,
              childAspectRatio: 2.5,
              crossAxisSpacing: 20.0,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  slide.length - KEY_RECIPE_OF_THE_WEEK_COOKING_INGREDIENTS,
                  (index) {
                return Text(
                  slide[KEY_RECIPE_OF_THE_WEEK_COOKING_INGREDIENTS + index],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlineButton(
                      child: AutoSizeText(
                        "Add ingredients to a list",
                      ),
                      onPressed: () {}),
                  Expanded(child: Container()),
                  OutlineButton(
                    child: Text("LET'S COOK !"),
                    onPressed: () async {
                      if (await canLaunch(slide[KEY_RECIPE_OF_THE_WEEK_URL]))
                        await launch(slide[KEY_RECIPE_OF_THE_WEEK_URL]);
                      else
                        Get.snackbar("Error", "Something went wrong!",
                            icon: Icon(Icons.warning));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
