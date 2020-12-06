import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String> getImage(context, bool hasUserProfilePicture) async {
  final picker = ImagePicker();
  String imagePath;

  await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              hasUserProfilePicture
                  ? new ListTile(
                      leading: new Icon(Icons.delete),
                      title: new Text('Remove profile picture'),
                      onTap: () async {
                        imagePath = "";
                        Navigator.pop(context);
                      })
                  : Container(),
              new ListTile(
                  leading: new Icon(Icons.add_photo_alternate),
                  title: new Text('Galery'),
                  onTap: () async {
                    PickedFile pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    imagePath = pickedFile.path;
                    Navigator.pop(context);
                  }),
              new ListTile(
                leading: new Icon(Icons.add_a_photo),
                title: new Text('Camera'),
                onTap: () async {
                  PickedFile pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  imagePath = pickedFile.path;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
  return imagePath;
}
