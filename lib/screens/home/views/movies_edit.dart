import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class MoviesEdit extends StatefulWidget {
  @override
  _MoviesEditState createState() => _MoviesEditState();
}

class _MoviesEditState extends State<MoviesEdit> {
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
