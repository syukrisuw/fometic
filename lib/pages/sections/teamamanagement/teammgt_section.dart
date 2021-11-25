import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TeammgtSection extends StatefulWidget {
  @override
  _TeammgtSectionSectionState createState() => _TeammgtSectionSectionState();
}

class _TeammgtSectionSectionState extends State<TeammgtSection> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: 30
        ),
        child : Text("Team Management Section")
    );
  }
}