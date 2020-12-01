import 'dart:ui';

import 'package:EasyGroceries/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle textStyleH1 = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 22.0,
);

const TextStyle textStyleH1Green =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 22.0, color: mainColor);

const TextStyle textStyleH1BoldUnderLine = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 22.0,
  decoration: TextDecoration.underline,
);

const TextStyle textStyleH1Accent =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 22.0, color: accentColor);

// H2

const TextStyle textStyleH2 = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 16.0,
);

const TextStyle textStyleH2BoldUnderLine = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    decoration: TextDecoration.underline);

const TextStyle textStyleH2Accent =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0, color: accentColor);

const TextStyle textStyleH2White =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.white);

// H3

const TextStyle textStyleH3Bold = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 14.0,
);

// special case

const TextStyle textStyleNext =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: mainColor);

const TextStyle textStyleSkip = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 16.0,
  color: secondaryColor,
);
