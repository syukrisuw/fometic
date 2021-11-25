
import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';

class FormContentDecoration extends InputDecoration {
  final String hintText;
  final String labelText;

  FormContentDecoration({required this.labelText, required this.hintText}):super(
    border: OutlineInputBorder(),
    hintText: hintText,
    labelText: labelText,
    labelStyle: formContentlabelStyle,
  );

}