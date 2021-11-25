import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AgendaSection extends StatefulWidget {
  @override
  _AgendaSectionState createState() => _AgendaSectionState();
}

class _AgendaSectionState extends State<AgendaSection> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 30
      ),
      child : Text("AgendaPage")
    );
  }
}