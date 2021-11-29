// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.



import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
//import 'package:simple_logger/simple_logger.dart';



/// A rectangular border with rounded selected corners.
///
/// Typically used with [ShapeDecoration] to draw a box with a rounded
/// rectangle.
///
/// This shape can interpolate to and from [CircleBorder].
///
/// See also:
///
///  * [BorderSide], which is used to describe each side of the box.
///  * [Border], which, when used with [BoxDecoration], can also
///    describe a rounded rectangle.
///
class CustomRRectBorder extends OutlinedBorder {
  /// Creates a rounded rectangle border.
  ///
  /// The arguments must not be null.
  const CustomRRectBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,

  }) : super(side: side);

  ///
  /// selected corner
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;
  ///
  /// The radii for each corner.
  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomRRectBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomRRectBorder) {
      return CustomRRectBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
      );
    }


    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {

    if (b is CustomRRectBorder) {
      return CustomRRectBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
      );
    }

    return super.lerpTo(b, t);
  }

  /// Returns a copy of this RoundedRectangleBorder with the given fields
  /// replaced with the new values.
  @override
  CustomRRectBorder copyWith({ BorderSide? side, BorderRadiusGeometry? borderRadius }) {
    return CustomRRectBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection? textDirection }) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, { TextDirection? textDirection }) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection? textDirection }) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        if (width == 0.0) {
          canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), side.toPaint());
        } else {
          final RRect outer = borderRadius.resolve(textDirection).toRRect(rect);
          final RRect inner = outer.deflate(width);
          final Paint paint = Paint()
            ..color = side.color;
          canvas.drawDRRect(outer, inner, paint);
        }
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is CustomRRectBorder
        && other.side == side
        && other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'RoundedPolygonBorder')}($side, $borderRadius)';
  }
}

enum SelectionCorner {topLeft, topRight, bottomLeft, bottomRight }

