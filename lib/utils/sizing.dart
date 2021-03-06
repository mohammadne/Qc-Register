import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPaddings {
  static const EdgeInsets smallPadding = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsets normalPadding = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets bigPadding = EdgeInsets.symmetric(vertical: 30);
}

class CustomBorders {
  static BorderRadius normalBorderRadius = BorderRadius.circular(10);
  static const Radius normalRadius = Radius.circular(10);
}

class CustomColors {
  static const pinkColor = Color(0xff7B4789);
}

class CustomSize {
  static const double titleHeight = 70.0;
  static const double itemSizes = 60.0;
}

class CustomGradient {
  static final gradient = LinearGradient(
    colors: [
      Colors.grey[700],
      Colors.grey[700],
      Colors.grey[700],
      Colors.grey[700],
    ],
  );
}
