import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingFavoriteFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lotties/food-prepared.json'),
        AutoSizeText(
          "What are your favorite types of food?",
          style: textStyleH1,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: SelectableTags([
              "Pizza",
              "Halal",
              "Japanese",
              "Sushi",
              "Indian",
              "African",
              "Thai",
              "Italian",
              "Chinese",
              "Desserts",
              "Healthy",
              "French",
              "American",
              "Salad",
              "Oriental",
              "Pasta",
            ]),
          ),
        ),
      ],
    );
  }
}
