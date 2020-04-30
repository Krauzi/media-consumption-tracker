import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class MoviesAdd extends StatefulWidget {
  @override
  _MoviesAddState createState() => _MoviesAddState();
}

class _MoviesAddState extends State<MoviesAdd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['blueish'],
      ),
    );
  }
}
