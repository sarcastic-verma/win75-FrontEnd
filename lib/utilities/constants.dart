import 'package:flutter/material.dart';

var kDefaultTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(12),
      hintStyle: TextStyle(),
      border: UnderlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
    ),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: Colors.purple,
    focusColor: Colors.purpleAccent,
    hintColor: Colors.pink,
    textTheme: TextTheme(
      button: TextStyle(color: Color(0xFF252525)),
      headline5: TextStyle(fontSize: 20.0, color: Colors.black),
      headline4: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
      headline3: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
      headline2: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black),
      headline1: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w300, color: Colors.black),
      subtitle1: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black),
      headline6: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
      bodyText2: TextStyle(fontSize: 12.0, color: Colors.black),
      bodyText1: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
      caption: TextStyle(fontSize: 12.0, color: Colors.black),
    ));
const Spades = 'SPADES';
const Club = 'CLUB';
const Success = 'SUCCESS';
const Fail = 'FAIL';
const Diamond = 'DIAMOND';
const Heart = 'HEART';
