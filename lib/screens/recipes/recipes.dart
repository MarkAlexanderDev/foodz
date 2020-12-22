import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recipes extends StatefulWidget {
  @override
  _Recipes createState() => _Recipes();
}

class _Recipes extends State<Recipes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(child: AutoSizeText("Recipes screen")));
  }
}
