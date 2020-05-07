import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/game_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

import 'games_edit.dart';

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
        .child("db").child(widget.userId).child("games").orderByChild("name");
  }

//  _onEntryAdded(Event event) {
//      setState(() {
//        _gamesList.add(Game.fromSnapshot(event.snapshot));
//      });
//  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: _gameQuery,
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        Game _game = Game.fromSnapshot(snapshot);

        return GameCard(game: _game, userId: widget.userId);
      },
    );
  }
}
