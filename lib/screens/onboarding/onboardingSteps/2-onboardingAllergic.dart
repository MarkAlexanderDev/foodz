import 'package:EasyGroceries/style/textStyle.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingAllergic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lotties/vr-sickness.json'),
        AutoSizeText(
          "Any food allergies?", //Any foods that you are allergic to?
          style: textStyleH1,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: SelectableTags([
              "Milk",
              "Eggs",
              "Peanuts",
              "Tree nuts",
              "Soy",
              "Wheat",
              "Fish",
              "Shellfish"
            ]),
          ),
        ),
      ],
    );
  }
}
