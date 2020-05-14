import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class MoviesView extends StatefulWidget {
  final String userId;

  MoviesView({this.userId});

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: applicationColors['white'],
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            backgroundColor: applicationColors['pink'],
            elevation: 0.0,
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("State", style: TextStyle(fontSize: 20.0))
                  ),
                ],
              ),
//              PopupMenuButton<String>(
//                onSelected: choiceAction,
//                itemBuilder: (BuildContext context){
//                  return Constants.choices.map((String choice){
//                    return PopupMenuItem<String>(
//                      value: choice,
//                      child: Text(choice),
//                    );
//                  }).toList();
//                },
//              )
            ],
          ),
        ),
        Positioned(
          top: 80.0,
          left: 0.0,
          bottom: 0.0,
          right: 0.0,
          child: Container(),
        ),
      ],
    );
  }
}
