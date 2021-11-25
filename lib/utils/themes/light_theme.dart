import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';

ThemeData lightTheme = ThemeData(
  primaryColorLight: Colors.black,
  canvasColor: const Color(0x0061B060),
  primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
  brightness: Brightness.light,
  cardColor: const Color(0xFF9EFF9C),
  cardTheme: const CardTheme(
    color: Colors.blue,
    elevation: minElevation,
    shadowColor: Colors.black26,
  ),
  scaffoldBackgroundColor: Colors.white, //Color(0xFF61B060),
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  backgroundColor: Colors.lightGreenAccent,
  focusColor: Colors.purpleAccent,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.deepPurple,
      backgroundColor: Color(0xFF9EFF9C),
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
  ),
  buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme(
          primary: Colors.greenAccent,
          primaryVariant: Colors.green,
          secondary: Colors.blueAccent,
          secondaryVariant: Color(0xFF041A81),
          surface: Colors.greenAccent,
          background: Colors.greenAccent,
          error: Colors.pinkAccent,
          onPrimary: Colors.greenAccent,
          onSecondary: Colors.greenAccent,
          onSurface: Colors.greenAccent,
          onBackground: Colors.greenAccent,
          onError: Colors.pinkAccent,
          brightness: Brightness.light),
      disabledColor: Colors.black26),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.only(left: minFormContentPadding),
    fillColor: Color(0xFF9EFF9C),
    filled: true,
    focusColor: Colors.brown,
    labelStyle: TextStyle(
      color: Colors.blueAccent,
      decorationColor: Colors.blueGrey,
    ),
    hintStyle: TextStyle(
      color: Colors.black12,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepOrange,
      )
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black54
      ),
      borderRadius: BorderRadius.all(Radius.circular(minBorderRadius)),
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
  textTheme: const TextTheme(
    headline1: TextStyle(
        color: Colors.black54, fontWeight: FontWeight.bold, fontSize: formTitleTextSize),
    bodyText1: TextStyle(color: Colors.black54, fontSize: formContentTextSize),
    button: TextStyle(color: Colors.black54, fontSize: formContentTextSize),
  ),
  colorScheme: const ColorScheme(
      primary: Colors.greenAccent,
      primaryVariant: Colors.green,
      secondary: Colors.blueAccent,
      secondaryVariant: Color(0xFF041A81),
      surface: Colors.greenAccent,
      background: Colors.greenAccent,
      error: Colors.pinkAccent,
      onPrimary: Colors.greenAccent,
      onSecondary: Colors.greenAccent,
      onSurface: Colors.greenAccent,
      onBackground: Colors.greenAccent,
      onError: Colors.pinkAccent,
      brightness: Brightness.light),
);
