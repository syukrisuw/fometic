import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:simple_logger/simple_logger.dart';

import 'borders/rounded_polygon_border.dart';
import 'borders/rounded_triangle_border.dart';
import 'borders/triangle_border.dart';
import 'dart:math' as math;
import 'custompainter/setara_bottom_navigation_painter.dart';

typedef _LetIndexPage = bool Function(int value);

typedef MenuCallback = void Function();
final logger = SimpleLogger();

class SetaraBottomNavigationBar extends StatefulWidget {
  final Key? key;
  final double? height;
  final double? width;
  final Color color;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<Icon> items;
  final int index;
  final MenuCallback? menuButtonCallback;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final Color? buttonBackgroundColor;

  SetaraBottomNavigationBar({
    this.key,
    this.color = Colors.white,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.width,
    this.height,
    this.menuButtonCallback,
    required this.items,
    this.index = 0,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.onTap,
    this.buttonBackgroundColor,
    _LetIndexPage? tmpLetIndexChange,
  })  : letIndexChange = tmpLetIndexChange ?? ((_) => true),
        assert(items != null),
        assert(items.length >= 1),
        super(key: key);

  @override
  State<SetaraBottomNavigationBar> createState() =>
      _SetaraBottomNavigationBarState();
}

class _SetaraBottomNavigationBarState extends State<SetaraBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color _borderColor = widget.borderColor ?? widget.color;
    final Color _backgroundColor = widget.backgroundColor ?? Colors.blueGrey;
    Size size = MediaQuery.of(context).size;
    final double _height =
        widget.height ?? MediaQuery.of(context).size.height / 12;
    final double _width = widget.width ??
        MediaQuery.of(context).size.width; //if not set, then cover all width
    final double _itemHeight = _height * 0.8;
    final double _itemWidth = _height * 0.8;
    return Container(
      height: _height,
      width: _width,
      color: _backgroundColor,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              color: _backgroundColor,
              height: _height,
              width: _width,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: SetaraBottomNavigationPainter(
                      width: _width,
                      height: _height,
                      backgroundColor: widget.color,
                      borderColor: _borderColor),
                ),
              ),
            ),
          ),
          Positioned(
            left: _width * 10 / 32,
            top: _height * 0.85,
            child: Container(
              color: Colors.blue,
              height: _height * 0.12,
              width: _width * 14 / 32,
              child: Center(
                child: Text(
                  "Flutter Powered Setara Application v0.0.1",
                  style: TextStyle(
                    fontSize: _height * 0.1,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: _height * 0.05,
            child: SizedBox(
              height: _height,
              width: _width * 3 / 8,
              //color: Colors.green.withAlpha(200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _width * 6 / 64,
                    height: _height * 0.6,
                    child: RepaintBoundary(
                      child: ElevatedButton(
                        key: UniqueKey(),
                        onPressed: widget.menuButtonCallback,
                        child: widget.items[0],
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xffaf8519),
                                width: 2.0,
                                style: BorderStyle.solid),
                          ),
                        ),
                        //style: Theme.of(context).elevatedButtonTheme.style,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _width * 6 / 64,
                    height: _height * 0.6,
                    child: RepaintBoundary(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: widget.items[1],
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(medButtonBorderRadius),
                                topRight:
                                Radius.circular(minButtonBorderRadius),
                                bottomLeft:
                                Radius.circular(medButtonBorderRadius),
                                bottomRight:
                                Radius.circular(minButtonBorderRadius),
                              ),
                              side: BorderSide(
                                  color: Color(0xffaf8519),
                                  width: 2.0,
                                  style: BorderStyle.solid)),

                          // shape: const RoundedPolygonBorder(side: BorderSide(color: Color(
                          //     0xffaf8519), width: 2.0, style: BorderStyle.solid), polyAngle: 3, radian: 0.5 * math.pi),),), //left facing rectangle will use radian = 180 degree or pi
                        ),
                        // style: ElevatedButton.styleFrom(
                        //   shape: const RoundedTriangleBorder(
                        //       side: BorderSide(
                        //           color: Color(0xffbbb41d),
                        //           width: 2.0,
                        //           style: BorderStyle.solid)),
                        // ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.pink,
                    width: _width * 6 / 64,
                    height: _height * 0.6,
                    child: RepaintBoundary(
                      child: ElevatedButton(
                        onPressed: () {
                          logger.info(
                              "ElevatedButton width: ${_width * 6 / 64}, height: ${_height * 0.6}");
                        },
                        child: widget.items[2],
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(minButtonBorderRadius),
                                topRight:
                                    Radius.circular(medButtonBorderRadius),
                                bottomLeft:
                                    Radius.circular(minButtonBorderRadius),
                                bottomRight:
                                Radius.circular(medButtonBorderRadius),
                              ),
                              side: BorderSide(
                                  color: Color(0xffaf8519),
                                  width: 2.0,
                                  style: BorderStyle.solid)),

                          // shape: const RoundedPolygonBorder(side: BorderSide(color: Color(
                          //     0xffaf8519), width: 2.0, style: BorderStyle.solid), polyAngle: 3, radian: 0.5 * math.pi),),), //left facing rectangle will use radian = 180 degree or pi
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: _height * 0.05,
            child: SizedBox(
              height: _height,
              width: _width * 1 / 8,
              //color: Colors.green.withAlpha(200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _width * 7 / 64,
                    height: _height * 0.7,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: widget.items[3],
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(medButtonBorderRadius),
                              topRight: Radius.circular(minButtonBorderRadius),
                              bottomLeft:
                                  Radius.circular(minButtonBorderRadius),
                              bottomRight:
                                  Radius.circular(minButtonBorderRadius),
                            ),
                            side: BorderSide(
                                color: Color(0xffaf8519),
                                width: 2.0,
                                style: BorderStyle.solid)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buttonTap(int index) {
    logger.info(" _buttonTap : index: $index");
  }
}
