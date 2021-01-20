import 'dart:io';

import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/states/app_states.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  if (imagePath == null)
    return null;
  else if (imagePath.isEmpty) return imagePath;
  return await uploadPictureFromLocalStorage(imagePath, "/images");
}

Future<String> uploadPictureFromLocalStorage(
    String pictureLocalStorageUrl, String storageRef) async {
  appStates.uploadingProfilePicture.value = true;
  if (pictureLocalStorageUrl == "") return "";
  final reference = firebaseStorage
      .ref()
      .child(storageRef + getImgNameFromPath(pictureLocalStorageUrl));
  final UploadTask uploadTask =
      reference.putFile(new File(pictureLocalStorageUrl));
  final snapshot = await uploadTask;
  final String url = await snapshot.ref.getDownloadURL();
  appStates.uploadingProfilePicture.value = false;
  return url;
}

String getImgNameFromPath(String imgPath) {
  return (imgPath.substring(imgPath.lastIndexOf("/"), imgPath.length));
}
