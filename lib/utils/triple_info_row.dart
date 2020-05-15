import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';

class TripleRow extends StatelessWidget {
  final String label1;
  final String label2;
  final String label3;
  final String text1;
  final String text2;
  final String text3;
  final Color color;
  final double fontSize;
  CrossAxisAlignment cAA = CrossAxisAlignment.start;
  MainAxisAlignment mAA = MainAxisAlignment.center;

  TripleRow({this.label1, this.label2, this.label3, this.text1, this.text2, this.text3,
    this.color, this.fontSize, this.cAA = CrossAxisAlignment.start, this.mAA = MainAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Column(
            crossAxisAlignment: cAA,
            mainAxisAlignment: mAA,
            children: <Widget>[
              Text(label1, style: TextStyle(fontSize: fontSize-4.0,
                  fontWeight: FontWeight.w300, color: color)),
              Text(text1, style: TextStyle(fontSize: fontSize, color: color)),
            ],
          ),
        ),
        Expanded(flex: 0, child: Container()),
        Expanded(flex: 1, child: Column(
            crossAxisAlignment: cAA,
            mainAxisAlignment: mAA,
            children: <Widget>[
              Text(label2, style: TextStyle(fontSize: fontSize-4.0,
                  fontWeight: FontWeight.w300, color: color)),
              Text(text2.capitalize(), style: TextStyle(fontSize: fontSize, color: color)),
            ],
          ),
        ),
        Expanded(flex: 0, child: Container()),
        Expanded(flex: 1, child: Column(
          crossAxisAlignment: cAA,
          mainAxisAlignment: mAA,
          children: <Widget>[
            Text(label3, style: TextStyle(fontSize: fontSize-4.0,
                fontWeight: FontWeight.w300, color: color)),
            Text(text3.capitalize(), style: TextStyle(fontSize: fontSize, color: color)),
          ],
        ),
        )
      ],
    );
  }
}
