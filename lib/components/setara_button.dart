import 'package:flutter/material.dart';

typedef OnButtonPressed = void Function();
class SetaraButton extends StatelessWidget {
  final double? height;
  final double? width;
  final OnButtonPressed onPressed;
  final Widget? child;

  SetaraButton({
    required this.onPressed,
    this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final _height = height?? 50;
    final _width = width?? 50;
    return SizedBox(height: _height, width: _width,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onPressed();
        },
        child:child),
    );
  }
}
