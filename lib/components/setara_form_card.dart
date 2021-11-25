import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic/models/setara_reactive_field.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SetaraFormWidget extends StatefulWidget {
  final Key? key;
  final String formTitle;
  final String formSubTitle;
  //final List<Widget> children;
  final List<SetaraReactiveField> reactiveFields;
  final GetxController? controller;

  const SetaraFormWidget({
    this.key,
    required this.formTitle,
    this.formSubTitle = "",
    required this.reactiveFields, //this.children,
    this.controller,
  }) : super(key: key);

  @override
  State<SetaraFormWidget> createState() => _SetaraFormWidgetState();
}

class _SetaraFormWidgetState extends State<SetaraFormWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return LayoutBuilder(
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
                    if (widget.formSubTitle != "") Text(widget.formSubTitle),
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
                  ? _buildSmallForm(context)
                  : _buildLargeForm(context),
            ),
          ],
        ));
      },
    );
  }

  Widget _buildSmallForm(BuildContext context) {
    var childSize = widget.reactiveFields.length;
    logger.info("_buildSmallForm: childSize:$childSize");
    if (childSize == 1) {
      return Form(
        child: getInputWidget(context, widget.reactiveFields.elementAt(0)),
      );
    }
    List<Widget> smallFormChildren = [];
    for (int i = 0; i < childSize; i++) {
      smallFormChildren
          .add(getInputWidget(context, widget.reactiveFields.elementAt(i)));
      if (i < childSize - 1) {
        smallFormChildren.add(const SizedBox(
          height: minFormContentPadding,
        ));
      }
    }
    logger.info("_buildSmallForm endChildSize: ${smallFormChildren.length}");
    return SingleChildScrollView(
      reverse: true,
      child: Form(
        child: Center(
          child: Column(
            children: smallFormChildren,
          ),
        ),
      ),
    );
  }

  Widget _buildLargeForm(BuildContext context) {
    var childSize = widget.reactiveFields.length;
    logger.info("_buildLargeForm: childSize:$childSize");
    int maxChildPerRow = MediaQuery.of(context).size.width ~/ 100;
    maxChildPerRow = 8;// min(maxChildPerRow, 8);
    logger.info("_buildLargeForm: maxChildPerRow:$maxChildPerRow");
    if (childSize == 1) {
      return Form(
        child: getInputWidget(context, widget.reactiveFields.elementAt(0)),
      );
    }

    List<Widget> columnFormChildren = [];
    int rowIndex = 0;
    for (int i = 0; i < childSize; i++) {

      List<Widget> rowFormChildren = <Widget>[]; // will prepare the row child
      //Prepare row children
      rowIndex +=1;
      logger.info("_buildLargeForm: Preparing row:$rowIndex");
      for(int j=0; j<maxChildPerRow; j++ ) {

        if (i<childSize) {
          var childRowElement = widget.reactiveFields.elementAt(i);
          logger.info("_buildLargeForm: child index :$i request for : ${childRowElement.columnFactor} sector");
          j += childRowElement.columnFactor;
          if (j<maxChildPerRow) {
            // add the element to fill all available row
            rowFormChildren.add(Expanded(
                flex: childRowElement.columnFactor,
                child: getInputWidget(context,
                    childRowElement)));

            //rowFormChildren.add(formSizeBoxSpacer);
            logger.info(
                "_buildLargeForm: child index :$i  added as rowFormChildren, occupied =$j");
            j -=1;
            i += 1;
          } else  if (j == maxChildPerRow){
            logger.info(
                "_buildLargeForm: child index :$i  added as rowFormChildren, occupied =$j no more child left in row");
            rowFormChildren.add(Expanded(
                flex: childRowElement.columnFactor,
                child: getInputWidget(context,
                    childRowElement)));
          } else  if (j > maxChildPerRow) {
            i -=1;
          }

        } else {
          logger.info("_buildLargeForm: no more child element");
        }
      }
      columnFormChildren.add(Row( children : rowFormChildren)); //add the row and continue to next row
       //Add vertical spacing if it's not the last child
      if (i < childSize - 1) {
        columnFormChildren.add(formSizeBoxSpacer);
      }
    }
    logger.info("_buildLargeForm endChildSize: ${columnFormChildren.length}");
    return SingleChildScrollView(
      reverse: true,
      child: Form(
        child: Center(
          child: Column(
            children: columnFormChildren,
          ),
        ),
      ),
    );
  }

  Widget getInputWidget(
      BuildContext context, SetaraReactiveField setaraReactiveField) {
    switch (setaraReactiveField.type) {
      case SetaraReactiveFieldType.stringType:
        {
          return Container(
              padding: const EdgeInsets.only(left: minContentPadding, right: minContentPadding),
              height: formContentHeight * 2,
              child : TextFormField(
              key: UniqueKey(),
              style: formContentLabelStyle(context),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: minContentPadding),
                border: const OutlineInputBorder(gapPadding: 0),
                labelText: setaraReactiveField.labelText,
                hintText: setaraReactiveField.hintText,
              ),),);
        }
      case SetaraReactiveFieldType.spacerType:
        {
          return const SizedBox(width: double.infinity, height:1);
        }
      case SetaraReactiveFieldType.buttonType:
        {
          return Container(
            padding: const EdgeInsets.only(left: minContentPadding, right: minContentPadding),
              height: formContentHeight * 2,
              width: double.infinity,
              child : ElevatedButton(
            onPressed: (){}, child: Text(setaraReactiveField.labelText, style: Theme.of(context).textTheme.bodyText1),
          ),);
        }
      case SetaraReactiveFieldType.numericType:
        {
          return Container(
              padding: const EdgeInsets.only(left: minContentPadding, right: minContentPadding),
    height: formContentHeight * 2,
    width: double.infinity,
    child : TextFormField(
            key: UniqueKey(),
            style: formContentLabelStyle(context),
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
            padding: const EdgeInsets.only(left: minContentPadding, right: minContentPadding),
            height: formContentHeight * 2,
            child : TextFormField(
                key: UniqueKey(),
                style: formContentLabelStyle(context),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: minContentPadding),
                  border: const OutlineInputBorder(gapPadding: 0),
                  labelText: setaraReactiveField.labelText,
                  hintText: setaraReactiveField.hintText,
                ),),
          );
        }
    }
  }
}

/*class SetaraFormCard extends StatelessWidget {
  final String formTitle;
  final String formSubTitle;
  final List<SetaraFormTextInput> children;
  final TeammgtController controller;
  const SetaraFormCard(
      {Key? key,
      required this.formTitle,
      required this.controller,
      this.formSubTitle = "",
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
        child: Column(
      children: [
        Text("Team Management"),
        TextFormField(
          controller: controller.emailTxCtr,
          style: const TextStyle(
            fontSize: formContentTextSize * smallScaleFactor,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: minPadding),
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Email Anda",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan User Name Anda';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.usernameTxCtr,
          style: const TextStyle(
            fontSize: formContentTextSize * smallScaleFactor,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: minPadding),
            border: OutlineInputBorder(),
            labelText: "Username",
            hintText: "Username Anda",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan User Name Anda';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.passwordTxCtr,
          style: const TextStyle(
            fontSize: formContentTextSize * smallScaleFactor,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: minPadding),
            border: OutlineInputBorder(),
            labelText: "Password",
            hintText: "Password Anda",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan User Name Anda';
            }
            return null;
          },
        ),
      ],
    ));
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


 */
