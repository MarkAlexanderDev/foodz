import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class ConfirmButton extends StatelessWidget {
  final onClick;

  ConfirmButton({@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: 50,
          width: appWidth,
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
