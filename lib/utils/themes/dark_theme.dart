import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';

ThemeData darkTheme = ThemeData(
  canvasColor: const Color(0x00125C02),
  primaryColorDark: const Color(0x125C02),
  primaryColor: Colors.deepPurpleAccent,
  primaryColorLight: Colors.white54,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black12,//const Color(0xFF125C02),
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  backgroundColor: const Color(0xFF125C02),
  focusColor: Colors.greenAccent,
  cardTheme: const CardTheme(
    color: Colors.green,
    elevation: minElevation,
    shadowColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: const Color(0xFF9EFF9C),
      backgroundColor: Colors.deepPurpleAccent,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme(
          primary: Colors.deepPurple,
          primaryVariant: Colors.deepPurpleAccent,
          secondary: Colors.pink,
          secondaryVariant: Colors.pinkAccent,
          surface: Colors.deepPurpleAccent,
          background: Colors.deepPurpleAccent,
          error: Colors.redAccent,
          onPrimary: Colors.deepPurpleAccent,
          onSecondary: Colors.deepPurpleAccent,
          onSurface: Colors.deepPurpleAccent,
          onBackground: Colors.deepPurpleAccent,
          onError: Colors.redAccent,
          brightness: Brightness.dark),
      disabledColor: Colors.black26),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Colors.deepPurpleAccent,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF046347)),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20),
    bodyText1: TextStyle(color: Colors.white,
    fontSize: 14),
    button: TextStyle(color: Colors.white,
        fontSize: 14),
  ),
  colorScheme: const ColorScheme(
      primary: Colors.deepPurple,
      primaryVariant: Colors.deepPurpleAccent,
      secondary: Colors.pink,
      secondaryVariant: Colors.pinkAccent,
      surface: Colors.deepPurpleAccent,
      background: Colors.deepPurpleAccent,
      error: Colors.redAccent,
      onPrimary: Colors.deepPurpleAccent,
      onSecondary: Colors.deepPurpleAccent,
      onSurface: Colors.deepPurpleAccent,
      onBackground: Colors.deepPurpleAccent,
      onError: Colors.redAccent,
      brightness: Brightness.dark),
);
