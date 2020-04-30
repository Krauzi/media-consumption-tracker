import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/add_form_field.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/process_button.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/custom_dialog.dart' as customDialog;

class GamesAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GamesAddState();
}

class GamesAddState extends State<GamesAdd>
    with SingleTickerProviderStateMixin {

  TextEditingController _gameName;

  List<DropdownMenuItem<String>> _dropDownPlatformItems;
  String _currentPlatform;
  List _platforms = [
    "PC",
    "PlayStation",
    "Xbox",
  ];

  bool _isFinished = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _gameName = TextEditingController();

    _dropDownPlatformItems = getDropDownMenuItems();
    _currentPlatform = _dropDownPlatformItems[0].value;
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
                Text("Add new game",
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
                ProcessButton(
                  text: "Add game",
                  color: applicationColors['pink'],
                  textColor: applicationColors['white'],
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 14.0
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
}