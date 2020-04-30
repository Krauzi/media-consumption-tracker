import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

typedef void OnClick();

class CustomFAB extends StatelessWidget {
  final IconData icon;
  final OnClick onPressed;

  CustomFAB({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: 0,
      highlightElevation: 0,
      child: Icon(icon),
      backgroundColor: applicationColors['pink'],
    );
  }
}
