import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class BooksView extends StatefulWidget {
  final String userId;

  BooksView({this.userId});

  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: applicationColors['purple'],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        )
    );
  }
}
