import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/screens/home/views/books_edit.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/navbar_icons.dart';

typedef void OnClick();

class BookCard extends StatelessWidget {
  final Book book;
  final String userId;

  BookCard({this.book, this.userId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (_) =>
              BooksEdit(userId: userId, buttonText: "Edit book", book: book,)
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
                    Text(book.name.toUpperCase(), style: TextStyle(fontSize: 18.0)),
                    Divider(height: 16.0, thickness: 1.6,),
                    Text("Title", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300)),
                    Text(book.author.toUpperCase(), style: TextStyle(fontSize: 18.0)),
                    Divider(height: 16.0, thickness: 1.6,),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Format",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300)),
                                Text(book.format.toUpperCase(),
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
                                Text("Book finished? ",
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300)),
                                Text(book.finished.toString().capitalize(),
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    book.finished ? Column (
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
                            Expanded(flex: 1, child: Text(DateFormat("yyyy-MM-dd").format(book.time),
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
                  MyFlutterApp.books, color: applicationColors['grey'],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
