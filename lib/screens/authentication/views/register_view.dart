import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_button.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_email_input.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_label.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/form_password_input.dart';
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

  AuthBloc _authBloc;
  StreamSubscription _authSubscription;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.getBloc();

    _authSubscription = _authBloc.signUpObservable.listen((user) {
      if (user == null) {
        failedLoginDialog();
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });

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
                  FormEmailInput(
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
                  FormPasswordInput(
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
                  FormPasswordInput(
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
                    onPressed: _onSignUpClick,
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

  void _onSignUpClick() {
    if(_emailController.text != null && _passwordController.text != null
        && _passwordRepeatController.text != null) {
      if (_passwordController.text == _passwordRepeatController.text) {
        _authBloc.signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );
      }
    }
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

  @override
  void dispose() {
    super.dispose();
    _authSubscription.cancel();
  }

  void failedLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Sign up failed'),
              content: const Text('Couldn\'t create new user.'),
              actions: <Widget>[
                FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()
                ),
              ]
          );
        });
  }
}