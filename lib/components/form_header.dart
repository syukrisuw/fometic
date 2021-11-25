import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(formTitlePadding),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: borderWidthSmall,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: formTitleMinHeight,
          ),
          child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Text(title, style: formTitleTextStyle),
              ),
            )
          ],
        )));
  }
}
