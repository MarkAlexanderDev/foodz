import 'package:EasyGroceries/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String pictureUrl;

  ProfilePicture(
      {@required this.height, @required this.width, this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
        child: pictureUrl == null
            ? Icon(
                Icons.person,
                size: height * 0.70,
                color: Colors.white,
              )
            : Container());
  }
}
