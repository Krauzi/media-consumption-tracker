import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/flight_shuffle_builder.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/double_info_row.dart';
import 'package:mediaconsumptiontracker/utils/single_info_row.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:mediaconsumptiontracker/utils/triple_info_row.dart';
import 'package:toast/toast.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  final String userId;
  final SearchType searchType;
  final bool fromQueryCard;

  MovieDetail({this.movie, this.userId, this.searchType, this.fromQueryCard});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  RldbBloc _rldbBloc;

  StreamSubscription _itemEditedSubcription;

  Color _mainColor;

  @override
  void initState() {
    super.initState();

    _rldbBloc = BlocProvider.getBloc();

    if (widget.searchType == SearchType.MOVIE)
      _mainColor = applicationColors['pink'];
    else
      _mainColor = applicationColors['blueish'];

    if (widget.fromQueryCard == true ) {
      _itemEditedSubcription = _rldbBloc.movieObservable.listen((response) {
        if (response.length == 0) {
          Toast.show("Could not edit an item",
              context, duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        } else {
          Toast.show("Item edited successfully",
              context, duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _itemEditedSubcription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: applicationColors['white'],
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Material(
              color: _mainColor,
              child: Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(flex: 0, child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: applicationColors['white'], size: 22.0,),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ),
                  ],
                ),
              ),
            )
          ),
          Positioned(
            top: 72.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              children: <Widget>[
                Container(
                  color: _mainColor,
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Text(widget.movie.title, style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w600,
                              color: applicationColors['white'])
                          )
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(flex: 35,
                              child: Hero(
                                tag: "heroCard${widget.movie.imdbID}",
                                flightShuttleBuilder: flightShuttleBuilder,
                                child:
                                widget.movie.poster != "N/A" ? Image.network(
                                    widget.movie.poster, fit: BoxFit.fitHeight):
                                Image.asset("assets/movies_placeholder.png",
                                  fit: BoxFit.fitHeight,)
                              )
                          ),
                          Expanded(flex: 65,
                              child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SingleRow(label1: "Director", text1: widget.movie.director,
                                        color: applicationColors['white'], fontSize: 18.0),
                                    Divider(height: 16.0, thickness: 1.6, color: applicationColors['white']),
                                    DoubleRow(label1: "Type", text1: widget.movie.type.capitalize(),
                                        label2: "Country", text2: widget.movie.country,
                                        fontSize: 18.0, color: applicationColors['white']),
                                    Divider(height: 16.0, thickness: 1.6, color: applicationColors['white']),
                                    SingleRow(label1: "Genre", text1: widget.movie.genre,
                                        color: applicationColors['white'], fontSize: 18.0),
                                    Divider(height: 16.0, thickness: 1.6, color: applicationColors['white']),
                                  ],
                                ),
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TripleRow(label1: "Runtime", text1: widget.movie.runtime,
                        label2: "Release year", text2: widget.movie.year,
                        label3: "Rating", text3: widget.movie.imdbRating,
                        fontSize: 20.0, color: applicationColors['black'],
                        cAA: CrossAxisAlignment.center, mAA: MainAxisAlignment.spaceEvenly,),
                      Divider(height: 28.0, thickness: 1.6, color: _mainColor),
                      SingleRow(label1: "Actors", text1: widget.movie.actors,
                        color: applicationColors['black'], fontSize: 16.0,),
                      SizedBox(height: 28.0),
                      widget.fromQueryCard ? Container(): GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.movie.finished = !widget.movie.finished;
                          });
                          _editMovie();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(flex: 0,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Text("Watched?", style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300)),
                                )),
                            Expanded(flex: 0, child:
                              (widget.movie.finished) ? Icon(Icons.visibility):
                              Icon(Icons.visibility_off,
                                  color: Colors.grey[400])
                            )
                          ],
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editMovie() {
    if (widget.searchType == SearchType.MOVIE)
      _rldbBloc.editMovie(widget.userId, widget.movie, widget.movie.key, 0, "movies");
    else
      _rldbBloc.editMovie(widget.userId, widget.movie, widget.movie.key, 0, "series");
  }
}
