import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/movie_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class MoviesView extends StatefulWidget {
  final String userId;

  MoviesView({Key key, this.userId}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  RldbBloc _rldbBloc;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Query _movieQuery;

  @override
  void initState() {
    super.initState();

    _rldbBloc = BlocProvider.getBloc();

    _movieQuery = _database.reference()
        .child("db").child(widget.userId).child("movies").orderByChild("time");
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
            title: Text("Movies/series"),
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
            query: _movieQuery,
            key: ValueKey(_movieQuery),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Movie _movie = Movie.fromSnapshot(snapshot);

              if (deletedKey == _movie.key) return Container();

              return Dismissible(
                  resizeDuration: Duration(milliseconds: 200),
                  key: Key(_movie.key),
                  onDismissed: (direction) async {
                    _rldbBloc.deleteMovie(widget.userId, _movie, _movie.key, index);

                    deletedKey = _movie.key;

                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Movie/series has been deleted.", textAlign: TextAlign.center)
                        )
                    );
                  },
                  background: Container(
                    color: applicationColors['rose'],
                    child: Icon(Icons.delete, color: applicationColors['white'], size: 48.0,),
                  ),
                  child: MovieCard(userId: widget.userId, movie: _movie,)
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
        _movieQuery = _database.reference()
            .child("db").child(widget.userId).child("movies").orderByChild("time");
      });
    } else if(choice == Constants.Finished) {
      setState(() {
        _movieQuery = _database.reference()
            .child("db").child(widget.userId).child("movies").orderByChild("finished").equalTo(true);
      });
    } else if(choice == Constants.Unfinished) {
      setState(() {
        _movieQuery = _database.reference()
            .child("db").child(widget.userId).child("movies").orderByChild("finished").equalTo(false);
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