import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class AddFormField extends StatelessWidget {

  final TextEditingController textController;
  final String label;

  AddFormField({ this.textController, this.label });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: textController,
        style: TextStyle(
            color: applicationColors['black'],
            fontSize: 15.0,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
          contentPadding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          fillColor: applicationColors['white'],
          filled: true,
        ),
      ),
    );
  }
}