import 'package:EasyGroceries/style/textStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CAcard extends StatelessWidget {
  final Map<String, dynamic> slide;

  CAcard({@required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: slide["onClick"],
        child: Container(
          decoration: slide["image"].isEmpty
              ? BoxDecoration()
              : BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.50), BlendMode.darken),
                      image: slide["imageFromNetwork"]
                          ? NetworkImage(slide["image"])
                          : AssetImage(slide["image"]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      slide["title"],
                      style: textStyleH1Accent,
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      slide["desc"],
                      style: textStyleH2White,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Center(
                  child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      AutoSizeText(slide["clickHint"],
                          style: textStyleH2Accent, maxLines: 1),
                      Expanded(
                          child:
                              SvgPicture.asset("assets/images/arrowDown.svg"))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
