import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/add_form_field.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/process_button.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/custom_dialog.dart' as customDialog;


class BooksAdd extends StatefulWidget {
  @override
  _BooksAddState createState() => _BooksAddState();
}

class _BooksAddState extends State<BooksAdd>
    with SingleTickerProviderStateMixin {

  TextEditingController _bookName;
  TextEditingController _author;

  bool _isFinished = false;
  DateTime _selectedDate = DateTime.now();

  List<DropdownMenuItem<String>> _dropDownFormatItems;
  String _currentFormat;
  List _formats = [
    "Print",
    "eBook",
    "Audio",
  ];

  @override
  void initState() {
    super.initState();

    _bookName = TextEditingController();
    _author = TextEditingController();

    _dropDownFormatItems = getDropDownMenuItems();
    _currentFormat = _dropDownFormatItems[0].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String format in _formats) {
      items.add(new DropdownMenuItem(value: format, child: new Text(format)));
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
                Text("Add new book",
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
                  label: "Book name",
                  textController: _bookName,
                ),
                AddFormField(
                  label: "Author",
                  textController: _author,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _currentFormat,
                          items: _dropDownFormatItems,
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
                          child: Text("Book finished?",)
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
                  text: "Add book",
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

  void changedDropDownItem(String selectedFormat) {
    setState(() { _currentFormat = selectedFormat; });
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