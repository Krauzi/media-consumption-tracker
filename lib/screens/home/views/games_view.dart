import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class GamesView extends StatefulWidget {
  @override
  _GamesViewState createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {

  FloatingActionButton _actionButton;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: applicationColors['white'],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        )
    );
  }
}
