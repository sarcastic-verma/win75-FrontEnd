import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AlertStyle kAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: true,
  isOverlayTapDismiss: true,
  descStyle: TextStyle(fontWeight: FontWeight.w300),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.black,
  ),
);
var kDefaultTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: Colors.green,
    focusColor: Colors.purpleAccent,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.pink,
        style: BorderStyle.solid,
        width: 2,
      )),
//          labelText: "Product Name",
      labelStyle: TextStyle(
        color: Colors.purple,
      ),
      hintStyle: TextStyle(
        color: Colors.grey[600],
      ),
//          hintText: "Enter your product name",

      // hintColor: Colors.blue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    ),
    hintColor: Colors.pink,
    textTheme: TextTheme(
      button: TextStyle(color: Color(0xFF252525)),
      headline5:
          TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'karla'),
      headline4: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'karla'),
      headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'karla'),
      headline2: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: 'karla'),
      headline1: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
          fontFamily: 'karla'),
      subtitle1: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: Colors.purple,
          fontFamily: 'karla'),
      headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'karla'),
      bodyText2:
          TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'karla'),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'karla'),
      caption:
          TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'karla'),
    ));
const spades = 'SPADES';
const club = 'CLUB';
const success = 'SUCCESS';
const fail = 'FAIL';
const kButtonTextStyle =
    TextStyle(fontFamily: 'karla', fontSize: 25, fontWeight: FontWeight.bold);
const kTextFieldDecoration = InputDecoration(
    prefixIcon: Icon(
      Icons.person,
      color: Colors.black,
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.black38,
      style: BorderStyle.solid,
      width: 2,
    )),
    labelText: "Enter Value",
    labelStyle: TextStyle(color: Colors.black, fontFamily: 'karla'),
    hintStyle: TextStyle(color: Colors.grey, fontFamily: 'karla'),
    hintText: "Enter",

// hintColor: Colors.blue,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ));
const inProgress = 'INPROGRESS';
const diamond = 'DIAMOND';
const heart = 'HEART';
const apiKey = 'sq0idp-wA8hI6PpyVi3k3oaEdkeKw';
