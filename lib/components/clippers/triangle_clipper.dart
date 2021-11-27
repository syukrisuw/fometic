import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double limit = size.shortestSide;
    Path path = Path()
    ..addPolygon([
      Offset(0, limit),
      Offset(limit/2,0),
      Offset(limit, limit),
    ], true);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}