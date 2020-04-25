import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'injection/bloc_module.dart';
import 'injection/dependency_module.dart';
import 'screens/authentication/authentication_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';


class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: appBlocs,
      dependencies: appDependencies,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Consumption Tracker',
        routes: _routes,
        initialRoute: '/',
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> get _routes => {
    '/': (context) => SplashScreen(),
    '/login': (context) => AuthenticationScreen(),
    '/home': (context) => HomeScreen()
  };
}