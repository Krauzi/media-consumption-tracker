import 'package:flutter/material.dart';

class SingleRow extends StatelessWidget {
  final String label1;
  final String text1;
  final Color color;
  final double fontSize;

  SingleRow({this.label1, this.text1, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label1, style: TextStyle(fontSize: fontSize-4.0, fontWeight: FontWeight.w300, color: color)),
          Text(text1, style: TextStyle(fontSize: fontSize, color: color)),
        ]
    );
  }
}
