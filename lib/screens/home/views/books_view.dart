import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/book_card.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class BooksView extends StatefulWidget {
  final String userId;

  BooksView({Key key, this.userId}) : super(key: key);

  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  RldbBloc _rldbBloc;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Query _bookQuery;

  @override
  void initState() {
    super.initState();

    _rldbBloc = BlocProvider.getBloc();

    _bookQuery = _database.reference()
        .child("db").child(widget.userId).child("books").orderByChild("time");
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
            query: _bookQuery,
            key: ValueKey(_bookQuery),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Book _book = Book.fromSnapshot(snapshot);

              if (deletedKey == _book.key) return Container();

              return Dismissible(
                  resizeDuration: Duration(milliseconds: 200),
                  key: Key(_book.key),
                  onDismissed: (direction) async {
                    _rldbBloc.deleteBook(userId: widget.userId, book: _book);

                    deletedKey = _book.key;

                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Book has been deleted.", textAlign: TextAlign.center)
                        )
                    );
                  },
                  background: Container(
                    color: applicationColors['rose'],
                    child: Icon(Icons.delete, color: applicationColors['white'], size: 48.0,),
                  ),
                  child: BookCard(book: _book, userId: widget.userId)
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
        _bookQuery = _database.reference()
            .child("db").child(widget.userId).child("books").orderByChild("time");
      });
    } else if(choice == Constants.Finished) {
      setState(() {
        _bookQuery = _database.reference()
            .child("db").child(widget.userId).child("books").orderByChild("finished").equalTo(true);
      });
    } else if(choice == Constants.Unfinished) {
      setState(() {
        _bookQuery = _database.reference()
            .child("db").child(widget.userId).child("books").orderByChild("finished").equalTo(false);
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
