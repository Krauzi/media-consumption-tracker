import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/movie_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class SeriesView extends StatefulWidget {
  final String userId;

  SeriesView({Key key, this.userId}) : super(key: key);

  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends State<SeriesView> {
  RldbBloc _rldbBloc;

  SearchType _searchType;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Query _seriesQuery;

  @override
  void initState() {
    super.initState();

    _rldbBloc = BlocProvider.getBloc();

    _searchType = SearchType.SERIES;

    _seriesQuery = _database.reference()
        .child("db").child(widget.userId).child("series").orderByChild("time");
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
            title: Text("Series"),
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
            query: _seriesQuery,
            key: ValueKey(_seriesQuery),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Movie _movie = Movie.fromSnapshot(snapshot);

              if (deletedKey == _movie.key) return Container();

              return Dismissible(
                  resizeDuration: Duration(milliseconds: 200),
                  key: Key(_movie.key),
                  onDismissed: (direction) async {
                    _rldbBloc.deleteMovie(widget.userId, _movie, _movie.key, index, "series");

                    deletedKey = _movie.key;

                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Series has been deleted.", textAlign: TextAlign.center)
                        )
                    );
                  },
                  background: Container(
                    color: applicationColors['rose'],
                    child: Icon(Icons.delete, color: applicationColors['white'], size: 48.0,),
                  ),
                  child: MovieCard(userId: widget.userId, movie: _movie, searchType: _searchType)
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
        _seriesQuery = _database.reference()
            .child("db").child(widget.userId).child("series").orderByChild("time");
      });
    } else if(choice == Constants.Finished) {
      setState(() {
        _seriesQuery = _database.reference()
            .child("db").child(widget.userId).child("series").orderByChild("finished").equalTo(true);
      });
    } else if(choice == Constants.Unfinished) {
      setState(() {
        _seriesQuery = _database.reference()
            .child("db").child(widget.userId).child("series").orderByChild("finished").equalTo(false);
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