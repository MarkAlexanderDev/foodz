import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingFavoriteFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Lottie.asset('assets/lotties/food-prepared.json'),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: AutoSizeText(
            "What are your favorite types${nbsp}of${nbsp}food?",
            style: textStyleH1,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.all(24.0),
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
      ],
    );
  }
}
