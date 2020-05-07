import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/add_form_field.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/process_button.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/custom_dialog.dart' as customDialog;
import 'package:toast/toast.dart';


class GamesEdit extends StatefulWidget {
  final String userId;
  final String buttonText;
  final Game game;

  GamesEdit({this.userId, this.buttonText, this.game});

  @override
  State<StatefulWidget> createState() => GamesEditState();
}

class GamesEditState extends State<GamesEdit>
    with SingleTickerProviderStateMixin {

  TextEditingController _gameName;

  List<DropdownMenuItem<String>> _dropDownPlatformItems;
  String _currentPlatform;
  List _platforms = [
    "PC",
    "PlayStation",
    "Xbox",
  ];

  bool _isFinished;
  DateTime _selectedDate;

  RldbBloc _rldbBloc;
  StreamSubscription _objectAddSubscription;

  List<String> text;

  @override
  void initState() {
    super.initState();

    _dropDownPlatformItems = getDropDownMenuItems();

    if (widget.game == null) {
      _gameName = TextEditingController();
      _currentPlatform = _dropDownPlatformItems[0].value;
      _isFinished = false;
      _selectedDate = DateTime.now();
    } else {
      _gameName = TextEditingController(text: widget.game.name);
      _currentPlatform = widget.game.platform;
      _isFinished = widget.game.finished;
      _selectedDate = widget.game.time;
    }

    _rldbBloc = BlocProvider.getBloc();

    text = widget.buttonText.toLowerCase().split(" ");

    _objectAddSubscription = _rldbBloc.objectEditResponseObservable.listen((response) {
      if (response == false) {
        Toast.show("Failed to ${text[0]} a ${text[1]}",
            context, duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        Navigator.pop(context);
      } else {
        Toast.show("${text[1].capitalize()} successfully ${text[0].toLowerCase()}ed",
            context, duration: Toast.LENGTH_LONG,
            gravity:  Toast.BOTTOM);
        Navigator.pop(context);
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String platform in _platforms) {
      items.add(new DropdownMenuItem(value: platform, child: new Text(platform)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return  customDialog.AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("${text[0].capitalize()} a ${text[1]}",
                  style: TextStyle(
                      color: applicationColors['black'],
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                AddFormField(
                  label: "Name",
                  textController: _gameName,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _currentPlatform,
                          items: _dropDownPlatformItems,
                          onChanged: changedDropDownItem,
                          decoration: InputDecoration(
                            labelText: "Select platform",
                            contentPadding: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(color: Colors.grey[600]),
                            ),
                            fillColor: applicationColors['white'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Text("Game finished?",)
                      ),
                      Expanded(
                          flex: 3,
                          child: Checkbox(
                            value: _isFinished,
                            onChanged: _isFinishedChanged,
                            checkColor: applicationColors['white'],
                            activeColor: applicationColors['pink'],
                          )
                      ),
                    ],
                  ),
                ),
                _isFinished ? Container(
                  padding: EdgeInsets.only(left: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(top: 14.0),
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(_selectedDate),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ProcessButton(
                          color: applicationColors['blueish'],
                          textColor: applicationColors['white'],
                          text: "Select date",
                          onPressed: _selectDate,
                          padding: EdgeInsets.symmetric(
                                horizontal: 6.0,
                                vertical: 8.0
                            )
                        ),
                      ),
                    ],
                  ),
                ) : new Container(),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ProcessButton(
                          text: widget.buttonText,
                          color: applicationColors['pink'],
                          textColor: applicationColors['white'],
                          onPressed: () { _sendData(); },
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                        ),
                      ),
                      Expanded(flex: 0, child: Container(width: 8.0,)),
                      Expanded(
                        flex: 1,
                        child: ProcessButton(
                          text: "Cancel",
                          color: applicationColors['grey'],
                          textColor: applicationColors['white'],
                          onPressed: () { Navigator.pop(context); },
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                        ),
                      ),
                    ]
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedPlatform) {
    setState(() { _currentPlatform = selectedPlatform; });
  }

  void _isFinishedChanged(bool value) => setState(() => _isFinished = value);

  void _selectDate() =>
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(200, 1, 1),
        maxTime: DateTime.now(), onChanged: (date) {
          setState(() => _selectedDate = date);

        }, onConfirm: (date) {
          setState(() => _selectedDate = date);
        },
        currentTime: DateTime.now(), locale: LocaleType.en);

  void _sendData() {
    if (_gameName.text != "") {
      if (widget.buttonText == "Add game"){
        Game _newGame = Game(_gameName.text.capitalize(), _currentPlatform, _isFinished, _selectedDate);
        _rldbBloc.addGame(userId: widget.userId, game: _newGame);
      } else {
        Game _newGame = widget.game;
        _newGame.name = _gameName.text.capitalize();
        _newGame.platform = _currentPlatform;
        _newGame.finished = _isFinished;
        _newGame.time = _selectedDate;
        _rldbBloc.editGame(userId: widget.userId, game: _newGame);
      }
    } else {
      Toast.show("Insert game name", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _gameName.dispose();
    _objectAddSubscription.cancel();
  }
}