import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class QueryFormField extends StatelessWidget {

  final TextEditingController textController;
  final String label;

  QueryFormField({ this.textController, this.label });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 2.0, bottom: 6.0),
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0))
          ),
          TextFormField(
            controller: textController,
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
    );
  }
}