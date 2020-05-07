import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/screens/home/views/games_edit.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/navbar_icons.dart';

typedef void OnClick();

class GameCard extends StatelessWidget {
  final Game game;
  final String userId;

  GameCard({this.game, this.userId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (_) =>
              GamesEdit(userId: userId, buttonText: "Edit game", game: game,)
          );
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 0.0, 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Title", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300)),
                    Text(game.name.toUpperCase(), style: TextStyle(fontSize: 18.0)),
                    Divider(height: 16.0, thickness: 1.6,),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Platform",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300)),
                                Text(game.platform.toUpperCase(),
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Expanded(flex: 0, child: Container()),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Game finished? ",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300)),
                                Text(game.finished.toString().capitalize(),
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    game.finished ? Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Divider(height: 16.0, thickness: 1.6),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                          Expanded(flex: 1, child: Text("Date: ",
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300))
                          ),
                          Expanded(flex: 0, child: Container()),
                          Expanded(flex: 1, child: Text(DateFormat("yyyy-MM-dd").format(game.time),
                              style: TextStyle(fontSize: 15.0)),),
                          ],
                        )
                      ],
                    ) : Container()
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  MyFlutterApp.games, color: applicationColors['grey'],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
