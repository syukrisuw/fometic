import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'dart:math';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SetaraBottomNavigationPainter extends CustomPainter {
  late double width;
  late double height;
  late Color? borderColor;
  late double borderWidth;
  final Color backgroundColor;
  final Color? centerColor;

  SetaraBottomNavigationPainter(
      {this.width = double.infinity,
      this.height = 60,
      this.backgroundColor = Colors.white,
      this.centerColor,
      this.borderColor,
      this.borderWidth = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Color _borderColor = borderColor ?? backgroundColor;
    final double _borderRadius = minRadius;
    //logger.info("paint this.width:${size.width}, this.height: ${height}");
    Paint paint1 = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Path path1 = Path()
      ..moveTo(0, height * 0.1) // .start
      ..lineTo((size.width * 12 / 32) - _borderRadius, (height * 0.1)) //--
      ..arcToPoint(Offset( (size.width * 12 / 32) , (height * 0.1)+_borderRadius) , radius: Radius.circular(_borderRadius), rotation: 1.0  )
      //..quadraticBezierTo(size.width * 12 / 32, (height * 0.1),
      //    size.width * 12 / 32, (height * 0.4)) // -\
      ..lineTo((size.width * 12 / 32), (height * 0.8) - _borderRadius ) //|
      ..arcToPoint(Offset( (size.width * 12 / 32) + _borderRadius, (height * 0.8)) , radius: Radius.circular(_borderRadius),  rotation: 1.0, clockwise: false,  )
      //..quadraticBezierTo(size.width * 12 / 32, (height * 0.8),
      //    size.width * 14 / 32, (height * 0.8)) //\-
      ..lineTo((size.width * 28 / 32) - _borderRadius, (height * 0.8)) //----
      ..arcToPoint(Offset( (size.width * 28 / 32), (height * 0.8) - _borderRadius) , radius: Radius.circular(_borderRadius),  rotation: 1.0, clockwise: false,  )
      //..quadraticBezierTo(size.width * 28 / 32, (height * 0.8),
      //    size.width * 28 / 32, (height * 0.5)) // -/
      ..lineTo(size.width * 28 / 32, (height * 0.1) + _borderRadius ) //|
      ..arcToPoint(Offset( (size.width * 28 / 32)+ _borderRadius, (height * 0.1) ), radius: Radius.circular(_borderRadius), rotation: 1.0  )
      // ..quadraticBezierTo(size.width * 28 / 32, (height * 0.1),
      //     size.width * 30 / 32, (height * 0.1)) // /-
      ..lineTo(size.width, (height * 0.1)) // .end
      ..lineTo(size.width, height)
      ..lineTo(0, size.height)
      ..close();
    //BottomNavigationBar
    canvas.drawPath(path1, paint1);
    Paint paint2 = Paint()
      ..color = _borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    //BottomNavigationBar Border
    canvas.drawPath(path1, paint2);

    Path path3 = Path()
      //..moveTo(size.width * 49 / 128, (height * 0.5)) // .start
      ..addRRect(RRect.fromLTRBR((size.width * 12 / 32) + _borderRadius/2, 0, (size.width * 28 / 32) - _borderRadius/2, (height * 0.8) - _borderRadius/2, Radius.circular(_borderRadius)));
      //..close();
    //BottomNavigationBar Message
    canvas.drawPath(path3, paint1);

    //BottomNavigationBar Message Border
    canvas.drawPath(path3, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //return true;
    //return false; //this != oldDelegate;
    return this != oldDelegate;
  }
}
