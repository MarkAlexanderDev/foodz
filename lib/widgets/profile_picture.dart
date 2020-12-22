import 'package:EasyGroceries/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String pictureUrl;
  final bool editMode;
  final onEdit;

  ProfilePicture(
      {@required this.height,
      @required this.width,
      @required this.pictureUrl,
      @required this.editMode,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          Container(
              height: height,
              width: width,
              decoration:
                  BoxDecoration(color: mainColor, shape: BoxShape.circle),
              child: pictureUrl == "" || pictureUrl == null
                  ? Icon(
                      Icons.person,
                      size: height * 0.70,
                      color: Colors.white,
                    )
                  : new Container(
                      decoration: new BoxDecoration(
                        border: Border.all(color: mainColor, width: 2),
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: NetworkImage(pictureUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
          Visibility(
            visible: editMode,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: accentColor,
                radius: 15,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () async {
                    await onEdit();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
