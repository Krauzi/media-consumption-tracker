import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/app_name.dart';
import 'package:mediaconsumptiontracker/screens/authentication/widgets/home_view_button.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

typedef void OnClick();

class HomeView extends StatelessWidget {
  final OnClick onLoginPressed;
  final OnClick onSignUpPressed;

  HomeView({this.onLoginPressed, this.onSignUpPressed});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['white']
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/mct_logo_black.png',
                  color: applicationColors['pink'],
                  height: MediaQuery.of(context).size.longestSide * 0.27,
                  width: MediaQuery.of(context).size.longestSide * 0.27,
                ),
              ),
              AppName(
                textColor: applicationColors['pink'],
                fontSize: 22.0,
              ),
              SizedBox(height: 38,),
              HomeViewButton(
                onPressed: onSignUpPressed,
                text: "Sign Up",
                color: applicationColors['blueish'],
                textColor: applicationColors['white'],
                splashColor: applicationColors['purple'],
              ),
              HomeViewButton(
                onPressed: onLoginPressed,
                text: "Login",
                color: applicationColors['pink'],
                textColor: applicationColors['white'],
                splashColor: applicationColors['rose'],
              )
            ],
          ),
        ),
      ),
    );
  }
}