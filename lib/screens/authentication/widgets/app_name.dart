import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final Color textColor;
  final double fontSize;

  AppName({this.textColor, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Media",
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
          Text(
            "Consumption",
            style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Tracker",
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
