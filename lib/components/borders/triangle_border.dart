// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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

enum TriangleFacing { left, right }     // left: <  or right: >


class TriangleBorder extends OutlinedBorder {
  /// Create a triangle border.
  ///
  /// The [side] argument must not be null.
  /// Default [facing] argument is left facing triangle
  final TriangleFacing facing;

  const TriangleBorder(
      {BorderSide side = BorderSide.none, this.facing = TriangleFacing.left})
      : assert(side != null),
        super(side: side);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) =>
      TriangleBorder(side: side.scale(t), facing: facing);

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TriangleBorder) {
      return TriangleBorder(
          side: BorderSide.lerp(a.side, side, t), facing: facing);
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is TriangleBorder) {
      return TriangleBorder(
          side: BorderSide.lerp(side, b.side, t), facing: facing);
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final double initStrokeWidth = (side.width > 0)? side.width : 0.0;
    final double maxStrokeWidth = min(initStrokeWidth, rect.shortestSide); // get the max Stroke Width
    final double limit = maxStrokeWidth;
    return Path()
      ..addPolygon([
        facing==TriangleFacing.right? Offset(0+limit/2,0+limit/2) : Offset(rect.width-limit/2, 0+limit/2),
        facing==TriangleFacing.right? Offset(rect.width-(limit/2), rect.height / 2) : Offset(0+limit/2, rect.height/2),
        facing==TriangleFacing.right? Offset(0+limit/2, rect.height-limit/2) : Offset(rect.width-limit/2, rect.height-limit/2),
      ], true);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addPolygon([
        facing==TriangleFacing.right? const Offset(0,0) : Offset(rect.width, rect.height),
        facing==TriangleFacing.right? Offset(rect.width, rect.height / 2):Offset(0, rect.height / 2),
        facing==TriangleFacing.right? Offset(0, rect.height) : Offset(rect.width, 0),
      ], true);
  }

  @override
  TriangleBorder copyWith({BorderSide? side}) {
    return TriangleBorder(side: side ?? this.side, facing: facing);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {

    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        {
          final double initStrokeWidth = (side.width > 0)? side.width : 0.0;
          final double maxStrokeWidth = min(initStrokeWidth, rect.shortestSide/2); // get the max Stroke Width
          final double limit = maxStrokeWidth;
          //Path
          Paint paint1 = Paint()
            ..color = side.color
            ..strokeWidth = limit
            ..style = PaintingStyle.stroke;
          Path path = Path()
            ..addPolygon([
            facing==TriangleFacing.right? Offset(0+limit/2,0+limit/2) : Offset(rect.width-limit/2, 0+limit/2),
            facing==TriangleFacing.right? Offset(rect.width-(limit/2), rect.height / 2) : Offset(0+limit/2, rect.height/2),
            facing==TriangleFacing.right? Offset(0+limit/2, rect.height-limit/2) : Offset(rect.width-limit/2, rect.height-limit/2),]
              ,true);

          canvas.drawPath(path, paint1);
          //canvas.drawCircle(rect.center, (rect.shortestSide - side.width) / 2.0,
          //    side.toPaint());
        }
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TriangleBorder && other.side == side;
  }

  @override
  int get hashCode => side.hashCode;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'TriangleBorder')}($side)';
  }
}
