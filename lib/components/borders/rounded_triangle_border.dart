// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fometic/components/borders/triangle_border.dart';
import 'package:simple_logger/simple_logger.dart';

/// A border that fits a triangle within the available space.
///
/// Typically used with [ShapeDecoration] to draw a triangle.
///
/// The [dimensions] assume that the border is being used in a square space.
/// When applied to a rectangular space, the border paints in the center of the
/// rectangle.
///
/// See also:
///
///  * [BorderSide], which is used to describe each side of the box.
///  * [Border], which, when used with [BoxDecoration], can also
///    describe a triangle.
///

class RoundedTriangleBorder extends OutlinedBorder {
  /// Create a triangle border.
  ///
  /// The [side] argument must not be null.
  /// Default [facing] argument is left facing triangle
  final TriangleFacing facing;

  const RoundedTriangleBorder(
      {BorderSide side = BorderSide.none, this.facing = TriangleFacing.left})
      : assert(side != null),
        super(side: side);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) =>
      RoundedTriangleBorder(side: side.scale(t), facing: facing);

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is RoundedTriangleBorder) {
      return RoundedTriangleBorder(
          side: BorderSide.lerp(a.side, side, t), facing: facing);
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is RoundedTriangleBorder) {
      return RoundedTriangleBorder(
          side: BorderSide.lerp(side, b.side, t), facing: facing);
    }
    return super.lerpTo(b, t);
  }

  ///inner boundary of the widget using this border
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {

    return getRoundedTrianglePath(rect);
  }

  ///outer boundary of the widget using this border
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {

    return getRoundedTrianglePath(rect);
  }

  @override
  RoundedTriangleBorder copyWith({BorderSide? side}) {
    return RoundedTriangleBorder(side: side ?? this.side, facing: facing);
  }

  ///painting the border
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {

    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        {
          final double initStrokeWidth = (side.width > 0) ? side.width : 0.0;
          final double maxStrokeWidth = min(initStrokeWidth,
              rect.shortestSide / 4); // get the max Stroke Width
          final double limit = maxStrokeWidth;
          final _width = rect.width;
          final _height = rect.height;
          final _strokeWidth =
              maxStrokeWidth; // Stroke cannot be larger than the minimum rect side
          final _adjustment = _strokeWidth / 2;
          final double widthPerEight = rect.width / 8;
          final double heightPerEight = rect.height / 8;
          final double widthPerHeight = rect.width / rect.height;

          //Path
          Paint paint = Paint()
            ..color = side.color
            ..strokeWidth = _strokeWidth
            ..style = PaintingStyle.stroke;
          Path path = Path();
          //Not pure triangular equation, but using approximation
          //to speed up the calculation

          if (facing == TriangleFacing.right) {
            //right facing
            path
              ..moveTo(_adjustment, rect.height / 2)
              ..lineTo(_adjustment,
                  heightPerEight + widthPerHeight + _adjustment) //|
              ..quadraticBezierTo(
                  _adjustment,
                  _adjustment,
                  widthPerEight + _adjustment,
                  heightPerEight / 2 + _adjustment) // ^
              ..lineTo(widthPerEight * 7 - _adjustment,
                  heightPerEight * 3 + _adjustment - widthPerHeight) // \
              ..quadraticBezierTo(
                  widthPerEight * 8 - _adjustment,
                  heightPerEight * 4,
                  widthPerEight * 7 - _adjustment,
                  heightPerEight * 5 - _adjustment + widthPerHeight) // >
              ..lineTo(
                  widthPerEight + widthPerHeight - _adjustment,
                  _height -
                      heightPerEight / 2 -
                      _adjustment +
                      widthPerHeight) //  /
              ..quadraticBezierTo(_adjustment, _height - _adjustment,
                  _adjustment, _height - heightPerEight / 2 - _adjustment) //v
              ..close();
          } else {
            //left facing
            path
              ..moveTo(_width - _adjustment, rect.height / 2)
              ..lineTo(_width - _adjustment,
                  heightPerEight + widthPerHeight + _adjustment) //|
              ..quadraticBezierTo(
                  _width - _adjustment,
                  _adjustment,
                  _width - widthPerEight - _adjustment,
                  heightPerEight / 2 + _adjustment) // ^
              ..lineTo(widthPerEight + _adjustment,
                  heightPerEight * 3 + _adjustment - widthPerHeight) // /
              ..quadraticBezierTo(
                  _adjustment,
                  heightPerEight * 4,
                  widthPerEight + _adjustment,
                  heightPerEight * 5 - _adjustment + widthPerHeight) // <
              ..lineTo(
                  widthPerEight * 7 + widthPerHeight - _adjustment,
                  _height -
                      heightPerEight / 2 -
                      _adjustment +
                      widthPerHeight) //  \
              ..quadraticBezierTo(
                  _width - _adjustment,
                  _height - _adjustment,
                  _width - _adjustment,
                  _height - heightPerEight / 2 - _adjustment) //v
              ..close();
          }
          path.close();

          canvas.drawPath(path, paint);
          //canvas.drawCircle(rect.center, (rect.shortestSide - side.width) / 2.0,
          //    side.toPaint());
        }
    }
  }

  Path getRoundedTrianglePath(Rect rect) {
    final double initStrokeWidth = (side.width > 0) ? side.width : 0.0;
    final double maxStrokeWidth =
        min(initStrokeWidth, rect.shortestSide / 4); // get the max Stroke Width
    final double limit = maxStrokeWidth;
    final _width = rect.width;
    final _height = rect.height;
    final _strokeWidth =
        maxStrokeWidth; // Stroke cannot be larger than the minimum rect side
    final _adjustment = _strokeWidth / 2;
    final double widthPerEight = rect.width / 8;
    final double heightPerEight = rect.height / 8;
    final double widthPerHeight = rect.width / rect.height;
    Path path = Path();
    //Not pure triangular equation, but using approximation
    //to speed up the calculation

    if (facing == TriangleFacing.right) {
      //right facing
      path
        ..moveTo(_adjustment, rect.height / 2)
        ..lineTo(_adjustment, heightPerEight + widthPerHeight + _adjustment) //|
        ..quadraticBezierTo(_adjustment, _adjustment,
            widthPerEight + _adjustment, heightPerEight / 2 + _adjustment) // ^
        ..lineTo(widthPerEight * 7 - _adjustment,
            heightPerEight * 3 + _adjustment - widthPerHeight) // \
        ..quadraticBezierTo(
            widthPerEight * 8 - _adjustment,
            heightPerEight * 4,
            widthPerEight * 7 - _adjustment,
            heightPerEight * 5 - _adjustment + widthPerHeight) // >
        ..lineTo(widthPerEight + widthPerHeight - _adjustment,
            _height - heightPerEight / 2 - _adjustment + widthPerHeight) //  /
        ..quadraticBezierTo(_adjustment, _height - _adjustment, _adjustment,
            _height - heightPerEight / 2 - _adjustment) //v
        ..close();
    } else {
      //left facing
      path
        ..moveTo(_width - _adjustment, rect.height / 2)
        ..lineTo(_width - _adjustment,
            heightPerEight + widthPerHeight + _adjustment) //|
        ..quadraticBezierTo(
            _width - _adjustment,
            _adjustment,
            _width - widthPerEight - _adjustment,
            heightPerEight / 2 + _adjustment) // ^
        ..lineTo(widthPerEight + _adjustment,
            heightPerEight * 3 + _adjustment - widthPerHeight) // /
        ..quadraticBezierTo(
            _adjustment,
            heightPerEight * 4,
            widthPerEight + _adjustment,
            heightPerEight * 5 - _adjustment + widthPerHeight) // <
        ..lineTo(widthPerEight * 7 + widthPerHeight - _adjustment,
            _height - heightPerEight / 2 - _adjustment + widthPerHeight) //  \
        ..quadraticBezierTo(
            _width - _adjustment,
            _height - _adjustment,
            _width - _adjustment,
            _height - heightPerEight / 2 - _adjustment) //v
        ..close();
    }
    path.close();
    return path;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RoundedTriangleBorder && other.side == side;
  }

  @override
  int get hashCode => side.hashCode;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'TriangleBorder')}($side)';
  }
}
