import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

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
