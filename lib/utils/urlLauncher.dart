import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Get.snackbar("Error", "Something went wrong!", icon: Icon(Icons.warning));
  }
}
