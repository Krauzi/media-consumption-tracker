import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/data/search.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_details.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/flight_shuffle_builder.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:toast/toast.dart';

class MoviesQueryCard extends StatefulWidget {
  final Search movie;
  final String userId;
  final int index;
  final SearchType searchType;

  MoviesQueryCard({this.movie, this.userId, this.index, this.searchType});

  @override
  _MoviesQueryCardState createState() => _MoviesQueryCardState();
}

class _MoviesQueryCardState extends State<MoviesQueryCard> {

  bool _watched;

  AlignmentGeometry _alignmentBookmarks = Alignment.centerRight;
  AlignmentGeometry _alignmentWatched = Alignment.centerLeft;

  StreamSubscription _itemAddedSubcription;
  StreamSubscription _getMovieSubcription;

  String _referenceKey;
  Movie _movie;

  RldbBloc _rldbBloc;

  @override
  void initState() {
    super.initState();

    _watched = false;

    _rldbBloc = BlocProvider.getBloc();

    _referenceKey = "";
    _movie = Movie();

    _itemAddedSubcription = _rldbBloc.movieObservable.listen((response) {
      if (response[1] == widget.index) {
        _movie = response[0];
        if (response[2] != "")
          _referenceKey = response[2];
      }

      if (response.length == 0) {
        Toast.show("Failed action",
            context, duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      } else {
        Toast.show("Successful action",
            context, duration: Toast.LENGTH_LONG,
            gravity:  Toast.BOTTOM);
      }
    });

    _getMovieSubcription = _rldbBloc.singleMovieObservable.listen((response) {
      if (response[1] == widget.index) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            MovieDetail(movie: response[0], userId: widget.userId,
                searchType: widget.searchType, fromQueryCard: true)));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _itemAddedSubcription.cancel();
    _getMovieSubcription.cancel();
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
              _rldbBloc.getSingleMovie(widget.movie.imdbID, widget.index);
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
                          Text("Title", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
                          Text(widget.movie.title, style: TextStyle(fontSize: 19.0)),
                          Divider(height: 16.0, thickness: 1.6),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded( flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Release year",
                                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
                                      Text(widget.movie.year, style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 0, child: Container()),
                                Expanded( flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Type",
                                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
                                      Text(widget.movie.type.capitalize(), style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 16.0, thickness: 0),
                          Stack(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              AnimatedCrossFade(
                                alignment: _alignmentWatched,
                                duration: Duration(milliseconds: 600),
                                firstChild: GestureDetector(
                                  onTap: () {
                                    setState(() {_watched = !_watched; _changeAlignmentWatched(); });
                                    _editMovie();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text("Watched?", style: TextStyle(
                                          fontSize: 15.0, fontWeight: FontWeight.w300)),
                                      (_watched) ? Icon(Icons.visibility):
                                      Icon(Icons.visibility_off, color: Colors.grey[400]),
                                    ],
                                  ),
                                ),
                                secondChild: Container(),
                                crossFadeState: (widget.movie.bookmark ?? false) ? CrossFadeState.showFirst:
                                CrossFadeState.showSecond,
                              ),
                              AnimatedAlign(
                                alignment: _alignmentBookmarks,
                                curve: Curves.ease,
                                duration: Duration(milliseconds: 800),
                                child: GestureDetector(
                                  onTap: () { setState(() {
                                    if (widget.movie.bookmark) {
                                      widget.movie.bookmark = false;
                                      _watched = false;
                                      _deleteMovie();
                                    }
                                    else {
                                      widget.movie.bookmark = true;
                                      _addMovie();
                                    }
                                    _changeAlignmentBookmarks();
                                  });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text("Bookmark", style: TextStyle(
                                          fontSize: 15.0, fontWeight: FontWeight.w300)),
                                      (widget.movie.bookmark == false || widget.movie.bookmark == null) ? Icon(Icons.star_border):
                                      Icon(Icons.star),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 150,
                        ),
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

  void _addMovie() {
    if (widget.searchType == SearchType.MOVIE)
      _rldbBloc.addMovie(widget.userId, widget.movie.imdbID, widget.index, "movies");
    else
      _rldbBloc.addMovie(widget.userId, widget.movie.imdbID, widget.index, "series");

  }

  void _editMovie() {
    _movie.finished = _watched;
    if (widget.searchType == SearchType.MOVIE)
      _rldbBloc.editMovie(widget.userId, _movie, _referenceKey, widget.index, "movies");
    else if (widget.searchType == SearchType.SERIES)
      _rldbBloc.editMovie(widget.userId, _movie, _referenceKey, widget.index, "series");
  }

  void _deleteMovie() {
    if (widget.searchType == SearchType.MOVIE)
      _rldbBloc.deleteMovie(widget.userId, _movie, _referenceKey, widget.index, "movies");
    else if (widget.searchType == SearchType.SERIES)
      _rldbBloc.deleteMovie(widget.userId, _movie, _referenceKey, widget.index, "series");
  }

  void _changeAlignmentBookmarks() {
    setState(() {
      _alignmentBookmarks = _alignmentBookmarks == Alignment.centerRight ? Alignment.centerLeft : Alignment.centerRight;
    });
  }

  void _changeAlignmentWatched() {
    setState(() {
      _alignmentWatched = _alignmentWatched == Alignment.centerRight ? Alignment.centerLeft : Alignment.centerRight;
    });
  }

}
