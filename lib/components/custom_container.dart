
import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();
class CustomContainer extends StatelessWidget {
  final Color cccolor;

  CustomContainer({
    required this.cccolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _ccwidth = 0.0;
    double _ccheight = 0.0;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _ccwidth = constraints.maxWidth;
        _ccheight = constraints.maxHeight;

        return Container(
          color: cccolor,
          width: double.infinity,
          child: Text(
            "ccwidth ${constraints.maxWidth}   ccheight: ${constraints.maxHeight}  ",
            style: Theme.of(context).textTheme.bodyText1),
        );
      },
    );
  }
}