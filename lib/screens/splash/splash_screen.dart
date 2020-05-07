import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SplashScreen> {

  AuthBloc _authBloc;
  StreamSubscription _authSubscription;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.getBloc();
    _authBloc.userLoggedIn();

    _authSubscription = _authBloc.userLoggedObservable.listen((user) {
      if(user == null) {
        debugPrint("USER VALUE: " + user.toString());
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        debugPrint("USERID: " + user.uid);
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: applicationColors['blueish'],
      ),
      child: SpinKitSquareCircle(
        size: MediaQuery.of(context).size.shortestSide * 0.4,
        color: applicationColors['pink'],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authSubscription.cancel();
  }
}