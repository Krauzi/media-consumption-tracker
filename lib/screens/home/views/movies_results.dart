import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/query_data.dart';
import 'package:mediaconsumptiontracker/data/search.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/movies_query_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class MoviesResults extends StatefulWidget {
  final List<Search> movies;
  final QueryData query;
  final SearchType searchType;

  MoviesResults({this.movies, this.query, this.searchType});

  @override
  _MoviesResultsState createState() => _MoviesResultsState();
}

class _MoviesResultsState extends State<MoviesResults> {

  int _currentPage;
  List<Search> _movies;
  String userId;

  StreamSubscription _moviesSubscription;
  StreamSubscription _authSubscription;

  AuthBloc _authBloc;
  RldbBloc _rldbBloc;

  Color _mainColor;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    if (widget.searchType == SearchType.MOVIE)
      _mainColor = applicationColors['pink'];
    else
      _mainColor = applicationColors['blueish'];

    _scrollController = new ScrollController();
    _currentPage = widget.query.page;
    _movies = widget.movies;
    List<Search> _moviesInitialValue = widget.movies;

    _authBloc = BlocProvider.getBloc();
    _rldbBloc = BlocProvider.getBloc();

    _authSubscription = _authBloc.userLoggedObservable.listen((user) {userId = user.uid;});

    _moviesSubscription = _rldbBloc.moviesObservable.listen((queryMovies) {
      setState(() {  _movies = [..._moviesInitialValue, ...queryMovies];});
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels - 50 == _scrollController.position.maxScrollExtent - 50) {
        _currentPage += 1; _getMovies();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

    _authSubscription.cancel();
    _moviesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return true as Future<bool>; },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: _mainColor,
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                    children: <Widget>[
                      Expanded(
                        flex: 0,
                        child: Material(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios, color: applicationColors['white'], size: 24.0,),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text("Navigate back to search", style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: applicationColors['white'],
                                      fontSize: 20.0
                                  )),
                                )
                              ],
                            )
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: applicationColors['white'],
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _movies.length,
                              itemBuilder: (context, index) {
                                return MoviesQueryCard(movie: _movies[index], userId: userId, index: index);
                              }
                          ),
//                          child: AnimatedList(
//                              controller: _scrollController,
//                              shrinkWrap: true,
//                              scrollDirection: Axis.vertical,
//                              initialItemCount: _movies.length,
//                              itemBuilder: (context, index, animation) {
//                                return MoviesQueryCard(movie: _movies[index], userId: userId,
//                                    index: index, searchType: widget.searchType);
//                              },
//                          ),
                        ),
                      ),
                    ]
                ),
              ]
            ),
          ),
        )
      ),
    );
  }

  _getMovies() {
    _rldbBloc.getMovies(
        widget.query.title, widget.query.type,
        widget.query.year, _currentPage
    );
  }
}
