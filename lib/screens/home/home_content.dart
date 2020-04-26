import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.getBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['maize'],
      ),
      child: Stack(
        children: <Widget>[
          _logOut()
        ],
      ),
    );
  }

  Widget _logOut() => Positioned (
    top: 8, left: 8,
    child: SafeArea(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(Icons.exit_to_app, color: applicationColors['pink'], size: 24.0,),
          onPressed: () {
            _authBloc.logOut();
            Navigator.of(context).pushReplacementNamed('/login');
          }
        ),
      ),
    ),
  );
}
