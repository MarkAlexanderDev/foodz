import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final onClick;

  ConfirmButton({@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: appWidth,
      child: FloatingActionButton(
        elevation: 0.0,
        onPressed: onClick,
        child: Container(
          decoration: BoxDecoration(
              color: mainColor, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: AutoSizeText(
              "CONFIRM",
              style: textStyleH1White,
            ),
          ),
        ),
      ),
    );
  }
}
