import 'package:get/get.dart';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalData extends GetxController {
  static var fontlistbold = 'bold';
  static var fontlistextrabold = 'extrabold';
  static var fontlistregular = 'regular';
  static var fontlistblack = 'black';
  static var fontlistmedium = 'medium';
  static var fontlistsemibold = 'semibold';
  static var abfontstyle = 'medium';

//*static************************************************************
  static Color redcolor = const Color(0xffF82647);
  static Color greencolor = const Color(0xff34c759);
  static Color darkpink = const Color(0xffaf52de);
  static Color whitecolor = const Color(0xffF6F8FA);
  static Color ofwhite = const Color(0xff7f8c8d);
  static Color fullwhite = const Color(0xffffffff);
  static Color orange = const Color(0xffFF9500);
  static Color grey = const Color(0xffD1D4D7);
  static Color darkgray = const Color(0xff989898);
  static Color ofblack = Colors.black54;
  static Color fullblk = Colors.black;

//*static*********Btn clor

  static Color btncolorgreen = const Color(0xff0D9444);
  static Color bluebtn = const Color(0xff2291FF);

  /////////////
  static NumberFormat formatCurrency = NumberFormat.currency(symbol: "");

  ///////////////////////////////////
  static Color colorPrimary = const Color(0xff2291FF);
  // static Color tr = const Color(0xff00000000);
  static Color colorPrimaryDark = const Color(0xff0276EA);
  static Color teal_200 = const Color(0xff2291FF);
  // static Color teal_700 = const Color(0xffff018786);
  static Color mediumgray = const Color(0xff949494);
  static Color gray = const Color(0xff656464);
  static Color bluecolor = const Color(0xff2291FF);
  static Color lightgraycolor = const Color(0xffF5F5F5);
  static Color progressbar = const Color(0xffe4e4e6);
  static Color btnapply = const Color(0xfff5f5f5);
  static Color viewgray = const Color(0xffe8e8e9);
  static Color green = const Color(0xff34c759);
  static Color red = const Color(0xffff0000);

  static Color darkyellow = const Color(0xffff9500);
  static Color darkred = const Color(0xffff3b30);
  static Color shippedcolor = const Color(0xff44bedf);

  ///////////////////////////////////

  static const List<Color> circleColors = [
    Color(0xfffffaea),
    Color(0xffedf7fd),
    Color(0xfffdf7ff),
    Color(0xfffffaea),
    Color(0xfff1fff6),
    Color(0xfffff5ec)
  ];
  Random random = Random();

  static Color randomGenerator() {
    return circleColors[Random().nextInt(circleColors.length)];
  }
}

class GlobalRadious {
  static BorderRadius radious_ = const BorderRadius.all(Radius.circular(10));
  static Border border = Border.all(color: GlobalData.darkgray, width: 0.5);
}

formateddate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd MMM yyyy hh:mm a');
  return outputFormat.format(inputDate);
}

datefomated(date) {
  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('yyyy MM dd');
  return outputFormat.format(inputDate);
}

formateddatelist(date) {
  var inputFormat = DateFormat('dd-MM-yyyy');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd MMM yyyy');
  return outputFormat.format(inputDate);
}
