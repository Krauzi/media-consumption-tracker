import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/game_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class GamesView extends StatefulWidget {
  final String userId;

  GamesView({Key key, this.userId}) : super(key: key);

  @override
  _GamesViewState createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  RldbBloc _rldbBloc;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Query _gameQuery;

  @override
  void initState() {
    super.initState();

    _rldbBloc = BlocProvider.getBloc();

    _gameQuery = _database.reference()
        .child("db").child(widget.userId).child("games").orderByChild("time");
  }

  @override
  void dispose() {
    super.dispose();
  }

  String deletedKey;

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
            title: Text("Games"),
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
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ],
          ),
        ),
        Positioned(
          top: 80.0,
          left: 0.0,
          bottom: 0.0,
          right: 0.0,
          child: FirebaseAnimatedList(
            query: _gameQuery,
            key: ValueKey(_gameQuery),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Game _game = Game.fromSnapshot(snapshot);

              if (deletedKey == _game.key) return Container();

              return Dismissible(
                  resizeDuration: Duration(milliseconds: 200),
                  key: Key(_game.key),
                  onDismissed: (direction) async {
                    _rldbBloc.deleteGame(userId: widget.userId, game: _game);

                    deletedKey = _game.key;

                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Game has been deleted.", textAlign: TextAlign.center)
                        )
                    );
                  },
                  background: Container(
                    color: applicationColors['rose'],
                    child: Icon(Icons.delete, color: applicationColors['white'], size: 48.0,),
                  ),
                  child: GameCard(game: _game, userId: widget.userId)
              );
            },
          ),
        ),
      ],
    );
  }

  void choiceAction(String choice){
    if (choice == Constants.All) {
      setState(() {
        _gameQuery = _database.reference()
            .child("db").child(widget.userId).child("games").orderByChild("time");
      });
    } else if(choice == Constants.Finished) {
      setState(() {
        _gameQuery = _database.reference()
            .child("db").child(widget.userId).child("games").orderByChild("finished").equalTo(true);
      });
    } else if(choice == Constants.Unfinished) {
      setState(() {
        _gameQuery = _database.reference()
            .child("db").child(widget.userId).child("games").orderByChild("finished").equalTo(false);
      });
    }
  }
}

class Constants {
  static const String All = 'All';
  static const String Finished = 'Finished';
  static const String Unfinished = 'Unfinished';

  static const List<String> choices = <String>[
    All,
    Finished,
    Unfinished
  ];
}