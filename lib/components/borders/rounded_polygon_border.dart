// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui show lerpDouble;
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:simple_logger/simple_logger.dart';

/// A rectangular border with rounded corners.
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
///  Radian determine the initial facing of the polygon also initial
///  rotation factor
final logger = SimpleLogger();
class RoundedPolygonBorder extends OutlinedBorder {
  /// Creates a rounded rectangle border.
  ///
  /// The arguments must not be null.
  const RoundedPolygonBorder({
    this.polyAngle = 3,
    BorderSide side = BorderSide.none,
    this.borderRadius = BorderRadius.zero, this.radian=0.0,
  })  : assert(polyAngle < 11),
        super(side: side);

  /// The radii for each corner.
  final BorderRadiusGeometry borderRadius;

  /// Total side of the polygon.
  final int polyAngle;

  /// Inital Radian
  final double radian;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return RoundedPolygonBorder(
        side: side.scale(t),
        borderRadius: borderRadius * t,
        polyAngle: polyAngle,
        radian: radian);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is RoundedPolygonBorder) {
      return RoundedPolygonBorder(
          side: BorderSide.lerp(
            a.side,
            side,
            t,
          ),
          borderRadius:
              BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
          polyAngle: polyAngle,
          radian: radian);
    }
    if (a is CircleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: borderRadius,
        circleness: 1.0 - t,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is RoundedPolygonBorder) {
      return RoundedPolygonBorder(
          side: BorderSide.lerp(side, b.side, t),
          borderRadius:
              BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
          polyAngle: polyAngle,
          radian: radian);
    }
    if (b is CircleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: borderRadius,
        circleness: t,
      );
    }

    return super.lerpTo(b, t);
  }

  /// Returns a copy of this RoundedRectangleBorder with the given fields
  /// replaced with the new values.
  @override
  RoundedPolygonBorder copyWith(
      {BorderSide? side, BorderRadiusGeometry? borderRadius}) {
    return RoundedPolygonBorder(
        side: side ?? this.side,
        borderRadius: borderRadius ?? this.borderRadius,
        polyAngle: polyAngle,
        radian: radian);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    logger.info("getInnerPath");
    int _sides = polyAngle;
    double _radius = rect.shortestSide / 2;
    double _radians = radian;
    double angle = (math.pi * 2) / polyAngle;

    Offset center = Offset(rect.width / 2, rect.height / 2);
    Offset startPoint = Offset(
        _radius * math.cos(_radians), _radius * math.sin(_radians));
    Path path = Path();
    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= _sides; i++) {
      double x = _radius * math.cos(_radians + angle * i) + center.dx;
      double y = _radius * math.sin(_radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    logger.info("getOuterPath");
    int _sides = polyAngle;
    double _radius = rect.shortestSide / 2;
    double _radians = radian;
    double angle = (math.pi * 2) / polyAngle;
    /// shape determined it location from the relative center Offsett(0,0)
    /// for easy transformation, center is gained by dividing the width and height by 2
    Offset center = Offset(rect.width / 2, rect.height / 2);
    Offset startPoint = Offset(
        _radius * math.cos(_radians), _radius * math.sin(_radians));
    Path path = Path();
    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);
    /// Learn more at https://blog.codemagic.io/flutter-custom-painter/
    /// the position will be : x = r * cos(radian) and y = r * sin(radian)


    for (int i = 1; i <= _sides; i++) {
      double x = _radius * math.cos(_radians + angle * i) + center.dx;
      double y = _radius * math.sin(_radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        {
          int _sides = polyAngle;
          double _strokeWidth = 5;
          double _radius = (rect.shortestSide / 2) - _strokeWidth/2;
          double _adjX = rect.width/2 - _radius - _strokeWidth/2;
          double _adjY = rect.height/2 - _radius - _strokeWidth/2;
          logger.info("rect.width:${rect.width}, rect.height:${rect.height}, _radius:$_radius,  paint _adjX:$_adjX , _adjY:$_adjY");
          double _radians = radian;

          var paint = Paint()
            ..color = Colors.teal
            ..strokeWidth = 5
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round;

          var path = Path();

          var angle = (math.pi * 2) / _sides;

          Offset center = Offset(rect.width / 2, rect.height / 2);
          Offset startPoint = Offset(
              _radius * math.cos(_radians) + (_adjX* math.cos(_radians)),
              _radius * math.sin(_radians) + (_adjY* math.sin(_radians))
          );

          path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

          for (int i = 1; i <= _sides; i++) {
            double x = _radius * math.cos(_radians + angle * i) + center.dx + (_adjX* math.cos(_radians + angle * i));
            double y = _radius * math.sin(_radians + angle * i) + center.dy + (_adjY* math.sin(_radians + angle * i));
            logger.info("x:$x, y:$y");
            path.lineTo(x, y);
          }
          path.close();
          canvas.drawPath(path, paint);
        }
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is RoundedPolygonBorder &&
        other.side == side &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'RoundedPolygonBorder')}($side, $borderRadius)';
  }
}

class _RoundedPolygonToCircleBorder extends OutlinedBorder {
  const _RoundedPolygonToCircleBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    required this.circleness,
  })  : assert(side != null),
        assert(borderRadius != null),
        assert(circleness != null),
        super(side: side);

  final BorderRadiusGeometry borderRadius;

  final double circleness;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return _RoundedPolygonToCircleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
      circleness: t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    assert(t != null);
    if (a is RoundedRectangleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
        circleness: circleness * t,
      );
    }
    if (a is CircleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: borderRadius,
        circleness: circleness + (1.0 - circleness) * (1.0 - t),
      );
    }
    if (a is _RoundedPolygonToCircleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
        circleness: ui.lerpDouble(a.circleness, circleness, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is RoundedPolygonBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
        circleness: circleness * (1.0 - t),
      );
    }
    if (b is CircleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: borderRadius,
        circleness: circleness + (1.0 - circleness) * t,
      );
    }
    if (b is _RoundedPolygonToCircleBorder) {
      return _RoundedPolygonToCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
        circleness: ui.lerpDouble(circleness, b.circleness, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  Rect _adjustRect(Rect rect) {
    if (circleness == 0.0 || rect.width == rect.height) return rect;
    if (rect.width < rect.height) {
      final double delta = circleness * (rect.height - rect.width) / 2.0;
      return Rect.fromLTRB(
        rect.left,
        rect.top + delta,
        rect.right,
        rect.bottom - delta,
      );
    } else {
      final double delta = circleness * (rect.width - rect.height) / 2.0;
      return Rect.fromLTRB(
        rect.left + delta,
        rect.top,
        rect.right - delta,
        rect.bottom,
      );
    }
  }

  BorderRadius? _adjustBorderRadius(Rect rect, TextDirection? textDirection) {
    final BorderRadius resolvedRadius = borderRadius.resolve(textDirection);
    if (circleness == 0.0) return resolvedRadius;
    return BorderRadius.lerp(resolvedRadius,
        BorderRadius.circular(rect.shortestSide / 2.0), circleness);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(_adjustBorderRadius(rect, textDirection)!
          .toRRect(_adjustRect(rect))
          .deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
          _adjustBorderRadius(rect, textDirection)!.toRRect(_adjustRect(rect)));
  }

  @override
  _RoundedPolygonToCircleBorder copyWith(
      {BorderSide? side,
      BorderRadiusGeometry? borderRadius,
      double? circleness}) {
    return _RoundedPolygonToCircleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      circleness: circleness ?? this.circleness,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        if (width == 0.0) {
          canvas.drawRRect(
              _adjustBorderRadius(rect, textDirection)!
                  .toRRect(_adjustRect(rect)),
              side.toPaint());
        } else {
          final RRect outer = _adjustBorderRadius(rect, textDirection)!
              .toRRect(_adjustRect(rect));
          final RRect inner = outer.deflate(width);
          final Paint paint = Paint()..color = side.color;
          canvas.drawDRRect(outer, inner, paint);
        }
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _RoundedPolygonToCircleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.circleness == circleness;
  }

  @override
  int get hashCode => hashValues(side, borderRadius, circleness);

  @override
  String toString() {
    return 'RoundedPolygonleBorder($side, $borderRadius, ${(circleness * 100).toStringAsFixed(1)}% of the way to being a CircleBorder)';
  }
}
