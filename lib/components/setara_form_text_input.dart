import 'package:flutter/material.dart';


class SetaraFormTextInput  extends StatelessWidget {

  final TextEditingController controller;
  final double columnFactor;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final String? hintText;
  final TextStyle? style;
  final Key? key;

  const SetaraFormTextInput({this.key, required this.controller,
    this.columnFactor = 1,
    this.validator,
    this.labelText,
    this.hintText, this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: style,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }

}