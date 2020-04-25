import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_button.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_input.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_label.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

typedef void OnClick();

class RegisterView extends StatefulWidget {
  final OnClick onBackPressed;
  final OnClick onLoginPressed;

  RegisterView({this.onBackPressed, this.onLoginPressed});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _passwordRepeatController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordRepeatController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['white'],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                      height: 12.0
                  ),
                  Center(
                    child: Image.asset(
                      'assets/mct_logo_black.png',
                      color: applicationColors['pink'],
                      height: MediaQuery.of(context).size.longestSide * 0.17,
                      width: MediaQuery.of(context).size.longestSide * 0.17,
                    ),
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                  FormLabel(
                    text: "email",
                    textColor: applicationColors['pink'],
                    icon: Icons.email,
                  ),
                  FormInput(
                    obscure: false,
                    borderColor: applicationColors['pink'],
                    controller: _emailController,
                    hint: 'example@example.com',
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  FormLabel(
                    text: "password",
                    textColor: applicationColors['pink'],
                    icon: Icons.lock,
                  ),
                  FormInput(
                    obscure: true,
                    borderColor: applicationColors['pink'],
                    controller: _passwordController,
                    hint: '',
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  FormLabel(
                    text: "confirm password",
                    textColor: applicationColors['pink'],
                    icon: Icons.lock,
                  ),
                  FormInput(
                    obscure: true,
                    borderColor: applicationColors['pink'],
                    controller: _passwordRepeatController,
                    hint: '',
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: FlatButton(
                          onPressed: widget.onLoginPressed,
                          child: Text(
                            "Already have an account?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: applicationColors['pink'],
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormButton(
                    text: "Sign Up",
                    color: applicationColors['rose'],
                    textColor: applicationColors['white'],
                    onPressed: () => {},
                  )
                ],
              ),
            ),
          ),
          _navigateBack()
        ],
      ),
    );
  }

  Widget _navigateBack() => Positioned (
    top: 8, left: 8,
    child: SafeArea(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: applicationColors['pink'], size: 24.0,),
          onPressed: widget.onBackPressed,
        ),
      ),
    ),
  );
}