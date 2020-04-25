import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final Color _textColor;
  final double _fontSize;

  AppName({Color textColor, double fontSize}) :
        _textColor = textColor,
        _fontSize = fontSize;

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
              color: _textColor,
              fontSize: _fontSize,
            ),
          ),
          Text(
            "Consumption",
            style: TextStyle(
                color: _textColor,
                fontSize: _fontSize,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Tracker",
            style: TextStyle(
              color: _textColor,
              fontSize: _fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
