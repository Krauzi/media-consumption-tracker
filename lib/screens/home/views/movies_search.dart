import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/query_data.dart';
import 'package:mediaconsumptiontracker/data/search.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_results.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/process_button.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/query_form_field.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:toast/toast.dart';

class MoviesSearch extends StatefulWidget {
  final String userId;

  MoviesSearch({this.userId});

  @override
  _MoviesSearchState createState() => _MoviesSearchState();
}

class _MoviesSearchState extends State<MoviesSearch> {

  TextEditingController _movieNameController;
  TextEditingController _movieYearController;

  List<DropdownMenuItem<String>> _dropDownTypeItems;
  String _currentType;
  List _types = [
    "All",
    "Movie",
    "Series",
    "Episode",
    "Game"
  ];


  StreamSubscription _moviesSubscription;
  RldbBloc _rldbBloc;

  @override
  void initState() {
    super.initState();
    _rldbBloc = BlocProvider.getBloc();

    _movieNameController = TextEditingController();
    _movieYearController = TextEditingController();
    _dropDownTypeItems = getDropDownMenuItems();
    _currentType = _dropDownTypeItems[0].value;

    _moviesSubscription = _rldbBloc.moviesObservable.listen(_showMovies);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String type in _types) {
      items.add(new DropdownMenuItem(value: type, child: new Text(type)));
    }
    return items;
  }

  @override
  void dispose() {
    super.dispose();

    _movieNameController.dispose();
    _movieYearController.dispose();
    _moviesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: applicationColors['white'],
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: applicationColors['pink'], size: 24.0,),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                      child: Text("Search for a movie", style: TextStyle(
                          color: applicationColors['pink'],
                          fontSize: 24.0, fontWeight: FontWeight.w300
                      )),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: QueryFormField(label: "Insert title", textController: _movieNameController)
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 18.0, bottom: 6.0, top:  16.0),
                        child: Text("Select type", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0))
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: _currentType,
                        items: _dropDownTypeItems,
                        onChanged: changedDropDownItem,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(color: Colors.grey[600]),
                          ),
                          fillColor: applicationColors['white'],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 2.0, bottom: 6.0),
                              child: Text("Insert year", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0))
                          ),
                          TextFormField(
                            controller: _movieYearController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              color: applicationColors['black'],
                              fontSize: 15.0,
                            ),
                            validator: (value) => value.isEmpty ? "" : value,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
                              contentPadding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              fillColor: applicationColors['white'],
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: ProcessButton(
                              text: "Search",
                              color: applicationColors['rose'],
                              textColor: applicationColors['white'],
                              onPressed: _onSearchClick,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            _loadPage
          ]
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedType) {
    setState(() { _currentType = selectedType; });
  }

  _onSearchClick() {
    if(_movieNameController.text != null && _movieNameController.text != "") {
      _currentType == "All" ? _rldbBloc.getMovies(_movieNameController.text, "", _movieYearController.text, 1):
      _rldbBloc.getMovies(_movieNameController.text, _currentType.toLowerCase(), _movieYearController.text, 1);
    } else {
      Toast.show("Insert title", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }

  _showMovies(List<Search> movies) {
    if (!ModalRoute.of(context).isCurrent) return;

    QueryData _query;
    if (_currentType == "All") {
      _query = QueryData(_movieNameController.text, "", _movieYearController.text, 1);
    } else {
      _query = QueryData(_movieNameController.text, _currentType.toLowerCase(), _movieYearController.text, 1);
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            MoviesResults(movies: movies, query: _query))
    ).then((_) {
      _moviesSubscription.cancel();
      _moviesSubscription = _rldbBloc.moviesObservable.listen(_showMovies);
    });
  }

  Widget get _loadPage => StreamBuilder<bool>(
    stream: _rldbBloc.loadingMoviesObservable,
    initialData: false,
    builder: (context, snapshot) {
      if(snapshot.data) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: applicationColors['white'],
          ),
          child: SpinKitDoubleBounce(
            size: MediaQuery.of(context).size.shortestSide * 0.4,
            color: applicationColors['pink'],
          ),
        );
      } else {
        return Container();
      }
    },
  );
}
