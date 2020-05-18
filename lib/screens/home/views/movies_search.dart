import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/search.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/movies_query_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/debouncer.dart';

class MoviesSearch extends StatefulWidget {
  final String userId;
  final SearchType searchType;

  MoviesSearch({this.userId, this.searchType});

  @override
  _MoviesSearchState createState() => _MoviesSearchState();
}

class _MoviesSearchState extends State<MoviesSearch> {

  TextEditingController _movieNameController;

  StreamSubscription _moviesSubscription;
  RldbBloc _rldbBloc;

  int _currentPage = 1;

  Color _mainColor;
  ScrollController _scrollController;

  List<Search> _movies = [];
  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));

  String _previousmovieNameText = "";

  @override
  void initState() {
    super.initState();
    _rldbBloc = BlocProvider.getBloc();

    if (widget.searchType == SearchType.MOVIE) {
      _mainColor = applicationColors['pink'];
    } else {
      _mainColor = applicationColors['blueish'];
    }

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels - 50 == _scrollController.position.maxScrollExtent - 50) {
        _currentPage += 1; _getMovies();
      }
    });

    _movieNameController = TextEditingController(text: "");
    _movieNameController.addListener(_onTextChange);

    _moviesSubscription = _rldbBloc.moviesObservable.listen((queryMovies) {
      setState(() {  _movies = queryMovies; });
    });
  }

  _onTextChange() {
    _debouncer.run(() {
      if (_movieNameController.text != _previousmovieNameText) {
        _previousmovieNameText = _movieNameController.text;
        _movies = [];
        _currentPage = 1;

        if (_movieNameController.text != null || _movieNameController.text != "") {
          _moviesSubscription.cancel();
          _moviesSubscription = _rldbBloc.moviesObservable.listen((queryMovies) {
            setState(() {  _movies = queryMovies; });
          });

          _getMovies();

        } else {
          _moviesSubscription.cancel();
          _moviesSubscription = _rldbBloc.moviesObservable.listen((queryMovies) {
            setState(() {  _movies = queryMovies; });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
    _movieNameController.removeListener(_onTextChange);
    _movieNameController.dispose();
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
                                child: Column(
                                  children: <Widget> [
                                    Row(
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
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: _movieNameController,
                                        style: TextStyle(
                                          color: applicationColors['white'],
                                          fontSize: 18.0,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: "Query search",
                                            hintStyle: TextStyle(color: applicationColors['white']),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: applicationColors['white']),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: applicationColors['white']),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: applicationColors['white']),
                                            )
                                        ),
                                      ),
                                    )
                                  ]
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
                                    return  MoviesQueryCard(movie: _movies[index],
                                      userId: widget.userId, index: index,
                                      searchType: widget.searchType,);
                                  }
                              ),
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
    if (widget.searchType == SearchType.MOVIE) {
      _rldbBloc.getMovies(_movieNameController.text, "movie", "", _currentPage);
    } else {
      _rldbBloc.getMovies(_movieNameController.text, "series", "", _currentPage);
    }
  }
}
