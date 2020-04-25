import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class FormInput extends StatelessWidget {
  final Color _borderColor;
  final bool _obscure;
  final TextEditingController _controller;
  final String _hint;


  FormInput({Color borderColor, bool obscure, TextEditingController controller, String hint}) :
        _borderColor = borderColor, _obscure = obscure, _controller = controller, _hint = hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: _borderColor,
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
              obscureText: _obscure,
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _hint,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              // autovalidate: true,
              autocorrect: false,
            ),
          ),
        ],
      ),
    );
  }
}
