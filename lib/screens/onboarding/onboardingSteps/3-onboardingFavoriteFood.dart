import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingFavoriteFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText("Favorite food"),
    );
  }
}
