import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic/components/setara_form_text_input.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SetaraFormCard extends StatelessWidget {
  final String formTitle;
  final String formSubTitle;
  final BoxConstraints constraints;
  final List<SetaraFormTextInput> children;
  SetaraFormCard(
      {Key? key,
      required this.formTitle,
      required this.constraints,
      this.formSubTitle = "",
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        padding: const EdgeInsets.all(minPadding),
        child: SingleChildScrollView(
            child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(formTitle,
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: minHeightPadding),
                (constraints.maxWidth > 400)
                    ? _buildWideContainers(
                        context, children, constraints.maxWidth)
                    : _buildNormalContainer2(children),
              ],
            ))));
  }

  Widget _buildWideContainers(BuildContext subContext,
      List<SetaraFormTextInput> children, double maxWidth) {
    logger.info("_buildWideContainers");
    int childSize = children.length;
    int maxChildInRow = maxWidth ~/ 300;
    //currently only allowed maximum 4 fields per row for proper display and spacing
    maxChildInRow = min(maxChildInRow, 4);

    List<Widget> newChildren = <Widget>[];
    if (childSize == 1) {
      logger.info("_buildWideContainers:childSize=1");
      return children.elementAt(0);
    }
    logger.info("_buildWideContainers:childSize=$childSize");
    for (int i = 0; i < childSize; i++) {
      if (i != (childSize - 1)) {
        double currentColumnFactor = children.elementAt(i).columnFactor;
        logger.info(
            "_buildWideContainers:childSize=$childSize , columnFactor:$currentColumnFactor , maxChildInRow:$maxChildInRow");
        if ((currentColumnFactor == 1) || (maxChildInRow < 2)) {
          // columnFactor = 1 => fill all width (1 child per row)
          // maxChildInRow < 2 => can only hold 1 child per row
          logger.info("_buildWideContainers: 1 child per row index i:$i");
          newChildren.add(children.elementAt(i));
        } else {
          //child can have other child in same row
          List<Widget> newRowChildren = <Widget>[];
          for (int j = 1; j <= maxChildInRow; j++) {
            double columnFactorReminder =
                1 - children.elementAt(i).columnFactor;
            newRowChildren.add(children.elementAt(i));
            if (columnFactorReminder <= (j / maxChildInRow)) {
              //only 3 out of 4 column left
              //add horizontal spacing and the child
              newRowChildren.add(const SizedBox(
                width: minPadding,
                height: minPadding,
              ));
              i += 1; //get next element
              newRowChildren.add(children.elementAt(i));
            }
          }
          newChildren.add(Row(children: newRowChildren));
        }
        //add vertical spacing
        newChildren.add(const SizedBox(
          width: minPadding,
          height: minPadding,
        ));
      } else {
        logger.info("_buildWideContainers: 1 child per row index i:$i");
        newChildren.add(children.elementAt(i));
      }
    }

    return Column(
      children: newChildren,
    );
  }

  Widget _buildNormalContainer(List<Widget> children) {
    logger.info("_buildNormalContainer");
    int childSize = children.length;

    List<Widget> newChildren = <Widget>[];
    for (var i = 0; i < childSize; i++) {
      newChildren.add(children.elementAt(i));
      if (i != (childSize - 1)) {
        newChildren.add(const SizedBox(
          width: minPadding,
          height: minPadding,
        ));
      }
    }
    return Column(
      children: newChildren,
    );
  }

  Widget _buildNormalContainer2(List<Widget> children) {
    logger.info("_buildNormalContainer2");
    return Column(children: [
      children.elementAt(0),
      const SizedBox(
        width: minPadding,
        height: minPadding,
      ),
      children.elementAt(1),
      const SizedBox(
        width: minPadding,
        height: minPadding,
      ),
      children.elementAt(2),
    ]);
  }
}
