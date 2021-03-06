import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String text;
  final Color textColor;
  final IconData icon;


  FormLabel({this.text, this.textColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 15.0,
                ),
                SizedBox(width: 8),
                Text(text.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
