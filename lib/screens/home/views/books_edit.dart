import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/add_form_field.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/process_button.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/string_extensions.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/custom_dialog.dart' as customDialog;
import 'package:toast/toast.dart';


class BooksEdit extends StatefulWidget {
  final String userId;
  final String buttonText;
  final Book book;

  BooksEdit({this.userId, this.buttonText, this.book});


  @override
  _BooksEditState createState() => _BooksEditState();
}

class _BooksEditState extends State<BooksEdit>
    with SingleTickerProviderStateMixin {

  TextEditingController _bookName;
  TextEditingController _author;

  bool _isFinished;
  DateTime _selectedDate;

  List<DropdownMenuItem<String>> _dropDownFormatItems;
  String _currentFormat;
  List _formats = [
    "Print",
    "eBook",
    "Audio",
  ];

  RldbBloc _rldbBloc;
  StreamSubscription _objectAddSubscription;

  List<String> text;

  @override
  void initState() {
    super.initState();

    _bookName = TextEditingController();
    _author = TextEditingController();

    _dropDownFormatItems = getDropDownMenuItems();
    _currentFormat = _dropDownFormatItems[0].value;

    if (widget.book == null) {
      _bookName = TextEditingController();
      _author = TextEditingController();
      _currentFormat = _dropDownFormatItems[0].value;
      _isFinished = false;
      _selectedDate = DateTime.now();
    } else {
      _bookName = TextEditingController(text: widget.book.name);
      _author = TextEditingController(text: widget.book.author);
      _currentFormat = widget.book.format;
      _isFinished = widget.book.finished;
      _selectedDate = widget.book.time;
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
                            labelText: "Select Formats",
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
                        Expanded(flex: 0, child: Container(width: 8.0)),
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

  void _sendData() {
    if (_bookName.text != "") {
      if (widget.buttonText == "Add book"){
        Book _newBook = Book(
            _bookName.text.capitalize(), _author.text.capitalize(),
            _currentFormat, _isFinished, _selectedDate
        );
        _rldbBloc.addBook(userId: widget.userId, book: _newBook);
      } else {
        Book _newBook = widget.book;
        _newBook.name = _bookName.text.capitalize();
        _newBook.author = _author.text.capitalize();
        _newBook.format = _currentFormat;
        _newBook.finished = _isFinished;
        _newBook.time = _selectedDate;
        _rldbBloc.editBook(userId: widget.userId, book: _newBook);
      }
    } else {
      Toast.show("Insert book name", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bookName.dispose();
    _author.dispose();
    _objectAddSubscription.cancel();
  }
}