import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_details.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/flight_shuffle_builder.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:toast/toast.dart';


class MovieCard extends StatefulWidget {

  final String userId;
  final Movie movie;
  final SearchType searchType;

  MovieCard({this.userId, this.movie, this.searchType});

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard>
    with TickerProviderStateMixin {

  RldbBloc _rldbBloc;

  StreamSubscription _itemEditedSubcription;

  @override
  void initState() {
    super.initState();

    _rldbBloc = BlocProvider.getBloc();

    _itemEditedSubcription = _rldbBloc.movieObservable.listen((response) {
      if (response.length == 0) {
        Toast.show("Could not edit an item",
            context, duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      } else {
        if (response.length != 4 && response[3] != true) {
          Toast.show("Item edited successfully",
              context, duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _itemEditedSubcription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0)),
        ),
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MovieDetail(movie: widget.movie, userId: widget.userId,
                    searchType: widget.searchType, fromQueryCard: false)));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Title", style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w300)),
                          Text(widget.movie.title,
                              style: TextStyle(fontSize: 19.0)),
                          Divider(height: 16.0, thickness: 0.4),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Release year",
                                          style: TextStyle(fontSize: 14.0,
                                              fontWeight: FontWeight.w300)),
                                      Text(widget.movie.year,
                                          style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 0, child: Container()),
                                Expanded(flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text("Type",
                                          style: TextStyle(fontSize: 14.0,
                                              fontWeight: FontWeight.w300)),
                                      Text(widget.movie.type.capitalize(),
                                          style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 16.0, thickness: 0.4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.movie.finished = !widget.movie.finished;
                              });
                              _editMovie();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Is it finished?", style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300)),
                                SizedBox(width: 12.0),
                                (widget.movie.finished) ? Icon(Icons.visibility) :
                                Icon(Icons.visibility_off,
                                    color: Colors.grey[400]),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Hero (
                        tag: "heroCard${widget.movie.imdbID}",
                        flightShuttleBuilder: flightShuttleBuilder,
                        child: widget.movie.poster != "N/A" ?
                        CachedNetworkImage(
                          imageUrl: widget.movie.poster,
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error)):
                        Image.asset("assets/movies_placeholder.png",
                          fit: BoxFit.fitHeight,)
                      )
                  )
                ],
              ),
            )
        )
    );
  }

  void _editMovie() {
    if (widget.searchType == SearchType.MOVIE)
      _rldbBloc.editMovie(widget.userId, widget.movie, widget.movie.key, 0, "movies");
    else
      _rldbBloc.editMovie(widget.userId, widget.movie, widget.movie.key, 0, "series");
  }
}
