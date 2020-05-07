import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/validate.dart';

class FormEmailInput extends StatelessWidget {
  final Color borderColor;
  final bool obscure;
  final TextEditingController controller;
  final String hint;

  FormEmailInput({this.borderColor, this.obscure, this.controller, this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: borderColor,
              width: 0.5,
              style: BorderStyle.solid
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              obscureText: obscure,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              autovalidate: true,
              autocorrect: false,
              validator: (value) {
                return !Validators.isValidEmail(value) ? 'Invalid Email' : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
