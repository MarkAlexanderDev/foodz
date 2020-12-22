import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingLists extends StatefulWidget {
  @override
  _ShoppingLists createState() => _ShoppingLists();
}

class _ShoppingLists extends State<ShoppingLists> {
  Future _future;

  @override
  void initState() {
    _future = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: 12,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30),
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            AutoSizeText(
                              "Monday's grocery list",
                              style: textStyleH3Bold,
                              textAlign: TextAlign.center,
                            ),
                            AutoSizeText("All my needs for the week !",
                                textAlign: TextAlign.center),
                          ]),
                        )),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
