import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String _text;
  final Color _textColor;
  final IconData _icon;


  FormLabel({String text, Color textColor, IconData icon}) :
        _text = text, _textColor = textColor, _icon = icon;

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
                  _icon,
                  size: 15.0,
                ),
                SizedBox(width: 8),
                Text(_text.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _textColor,
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
