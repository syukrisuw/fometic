import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic/models/setara_reactive_field.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SetaraResponsiveFormCardWidget extends StatefulWidget {
  final Key? setaraWidgetKey;
  final String formTitle;
  final String formSubTitle;
  final List<SetaraReactiveField> reactiveFields;
  final FocusNode? initialFocusNode;

  const SetaraResponsiveFormCardWidget({
    this.setaraWidgetKey,
    this.initialFocusNode,
    required this.formTitle,
    this.formSubTitle = "",
    required this.reactiveFields, //this.children,
  }) : super(key: setaraWidgetKey);

  @override
  State<StatefulWidget> createState() {
    return _SetaraResponsiveFormCardWidgetState();
  }
}

class _SetaraResponsiveFormCardWidgetState
    extends State<SetaraResponsiveFormCardWidget> {
  //private data
  final List<Widget> _formFieldList = <Widget>[];
  Widget? _widget;
  late final String formTitle; // = widget.formTitle;
  late final String formSubTitle; // = widget.formSubTitle;
  late final List<SetaraReactiveField> reactiveFields;
  late final int childSize;

  @override
  void initState() {
    super.initState();
    childSize = widget.reactiveFields.length;
    initiateWidget(childSize);
  }

  @override
  Widget build(BuildContext context) {
    final int _totalFields = widget.reactiveFields.length;
    initiateWidget(_totalFields);
    _widget ??= LayoutBuilder(
      builder: (context, constraints) {
        return Card(
            margin: const EdgeInsets.all(minFormOuterPadding),
            borderOnForeground: true,
            child: Column(
              children: [
                Container(
                  //Header Section of the form
                  padding: const EdgeInsets.all(minPadding),
                  decoration: formHeaderBoxDecoration(context),
                  child: Center(
                    child: Column(
                      children: [
                        Text(widget.formTitle,
                            style: Theme.of(context).textTheme.headline1),
                        if (widget.formSubTitle != "")
                          Text(widget.formSubTitle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: minFormContentPadding),
                Container(
                  //Content Section of the form
                  //decoration: formContentBoxDecoration(context),
                  padding: const EdgeInsets.all(minPadding),
                  child: constraints.maxWidth < 400
                      ? _buildSmallForm(context, _totalFields)
                      : _buildLargeForm(context, _totalFields),
                ),
              ],
            ));
      },
    );
    return _widget!;
  }

  Widget _buildSmallForm(BuildContext context, int childSize) {
    logger.info("_buildSmallForm: childSize:$childSize");
    if (childSize == 1) {
      return Container(
        color: Colors.white70,
        child: getInputWidgetByIndex(0),
        //getInputWidget(context, widget.reactiveFields.elementAt(0)),
      );
    }

    List<Widget> smallFormChildren = [];
    for (int i = 0; i < childSize; i++) {
      smallFormChildren.add(getInputWidgetByIndex(i));
      //smallFormChildren
      //           .add(getInputWidget(context, widget.reactiveFields.elementAt(i)));
      if (i < childSize - 1) {
        smallFormChildren.add(const SizedBox(
          height: minFormContentPadding,
        ));
      }
    }
    logger.info("_buildSmallForm endChildSize: ${smallFormChildren.length}");
    return Container(
      color: Colors.white70,
      child: Center(
        child: Column(
          children: smallFormChildren,
        ),
      ),
    );
  }

  Widget _buildLargeForm(BuildContext context, int childSize) {
    logger.info("_buildLargeForm: childSize:$childSize");
    int maxChildPerRow = MediaQuery.of(context).size.width ~/ 100;
    maxChildPerRow = 8; // min(maxChildPerRow, 8);
    logger.info("_buildLargeForm: maxChildPerRow:$maxChildPerRow");
    if (childSize == 1) {
      return getInputWidgetByIndex(0);
    }

    List<Widget> columnFormChildren = [];
    int rowIndex = 0;
    for (int i = 0; i < childSize; i++) {
      List<Widget> rowFormChildren = <Widget>[]; // will prepare the row child
      //Prepare row children
      rowIndex += 1;
      logger.info("_buildLargeForm: Preparing row:$rowIndex");
      for (int j = 0; j < maxChildPerRow; j++) {
        if (i < childSize) {
          var childRowElement = widget.reactiveFields.elementAt(i);
          logger.info(
              "_buildLargeForm: child index :$i request for : ${childRowElement.columnFactor} sector");
          j += childRowElement.columnFactor;
          if (j < maxChildPerRow) {
            // add the element to fill all available row
            rowFormChildren.add(Expanded(
              flex: childRowElement.columnFactor,
              child: getInputWidgetByIndex(i),
            )); //getInputWidget(context,
            //childRowElement)));

            //rowFormChildren.add(formSizeBoxSpacer);
            logger.info(
                "_buildLargeForm: child index :$i  added as rowFormChildren, occupied =$j");
            j -= 1;
            i += 1;
          } else if (j == maxChildPerRow) {
            logger.info(
                "_buildLargeForm: child index :$i  added as rowFormChildren, occupied =$j no more child left in row");
            rowFormChildren.add(Expanded(
              flex: childRowElement.columnFactor,
              child: getInputWidgetByIndex(i),
            )); //getInputWidget(context,
            //childRowElement)));
          } else if (j > maxChildPerRow) {
            i -= 1;
          }
        } else {
          logger.info("_buildLargeForm: no more child element");
        }
      }
      columnFormChildren.add(Row(
          children: rowFormChildren)); //add the row and continue to next row
      //Add vertical spacing if it's not the last child
      if (i < childSize - 1) {
        columnFormChildren.add(formSizeBoxSpacer);
      }
    }
    logger.info("_buildLargeForm endChildSize: ${columnFormChildren.length}");
    return Container(
      color: Colors.white70,
      child: Center(
        child: Column(
          children: columnFormChildren,
        ),
      ),
    );
  }

  Widget getInputWidgetByIndex(int index) {
    return _formFieldList.elementAt(index);
  }

  Widget initiateInputWidget(
      SetaraReactiveField setaraReactiveField, FocusNode? initFocusNode) {
    switch (setaraReactiveField.type) {
      case SetaraReactiveFieldType.stringType:
        {
          return Container(
              padding: const EdgeInsets.only(
                  left: minContentPadding, right: minContentPadding),
              height: formContentHeight * 2,
              child: TextFormField(
                focusNode: initFocusNode ?? setaraReactiveField.focusNode,
                controller: setaraReactiveField.controller,
                key: setaraReactiveField.key,
                style: setaraReactiveField.textStyle,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: minContentPadding),
                  border: const OutlineInputBorder(gapPadding: 0),
                  labelText: setaraReactiveField.labelText,
                  hintText: setaraReactiveField.hintText,
                ),
              ));
        }
      case SetaraReactiveFieldType.spacerType:
        {
          return const SizedBox(width: double.infinity, height: 200);
        }
      case SetaraReactiveFieldType.buttonType:
        {
          return Container(
            padding: const EdgeInsets.only(
                left: minContentPadding, right: minContentPadding),
            height: formContentHeight * 2,
            width: double.infinity,
            child: ElevatedButton(
              key: setaraReactiveField.key,
              onPressed: setaraReactiveField.onPressed,
              child: Text(setaraReactiveField.labelText),
            ),
          );
        }
      case SetaraReactiveFieldType.numericType:
        {
          return Container(
              padding: const EdgeInsets.only(
                  left: minContentPadding, right: minContentPadding),
              height: formContentHeight * 2,
              width: double.infinity,
              child: TextFormField(
                key: setaraReactiveField.key,
                focusNode: initFocusNode ?? setaraReactiveField.focusNode,
                style: setaraReactiveField.textStyle,
                controller: setaraReactiveField.controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: setaraReactiveField.labelText,
                  hintText: setaraReactiveField.hintText,
                ),
              ));
        }
      default:
        {
          return Container(
            padding: const EdgeInsets.only(
                left: minContentPadding, right: minContentPadding),
            height: formContentHeight * 2,
            child: TextFormField(
              key: setaraReactiveField.key,
              focusNode: initFocusNode ?? setaraReactiveField.focusNode,
              controller: setaraReactiveField.controller,
              style: setaraReactiveField.textStyle,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: minContentPadding),
                border: const OutlineInputBorder(gapPadding: 0),
                labelText: setaraReactiveField.labelText,
                hintText: setaraReactiveField.hintText,
              ),
            ),
          );
        }
    }
  }

  void initiateWidget(int childSize) {
    ///Give the first field an initialFocusNode if injected from parent
    _formFieldList.add(
        initiateInputWidget(widget.reactiveFields[0], widget.initialFocusNode));
    if (childSize > 1) {
      for (int i = 1; i < childSize; i++) {
        _formFieldList.add(initiateInputWidget(widget.reactiveFields[i], null));
      }
    }
  }
}
