import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// colors
const Color hotPink = Color(0xFFf72585);
const Color purple = Color(0xff7209b7);
const Color violet = Color(0xff3a0ca3);
const Color blue = Color(0xff4361ee);
const Color cyan = Color.fromARGB(255, 67, 175, 238);
const Color offWhite = Color(0xfff5f5f5);
const Color grey = Color.fromARGB(255, 51, 51, 51);
// text
const TextStyle defaultStyle = TextStyle(fontSize: 12, color: grey);

// height and width
double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
