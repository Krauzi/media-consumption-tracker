import 'package:flutter/material.dart';

typedef void OnClick();

class ProcessButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final OnClick onPressed;
  final EdgeInsets padding;

  ProcessButton({this.text, this.color, this.textColor, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)
              ),
              color: color,
              onPressed: onPressed,
              child: Container(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        text.toUpperCase(), textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
