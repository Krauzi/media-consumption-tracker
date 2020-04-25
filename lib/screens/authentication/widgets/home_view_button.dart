import 'package:flutter/material.dart';

typedef void OnClick();

class HomeViewButton extends StatelessWidget {
  final OnClick onPressed;
  final String text;
  final Color textColor;
  final Color color;
  final Color splashColor;

  HomeViewButton({this.onPressed, this.text,
    this.color, this.textColor, this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              color: color,
              splashColor: splashColor,
              onPressed: onPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        text.toUpperCase(), textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor, fontSize: 15.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}