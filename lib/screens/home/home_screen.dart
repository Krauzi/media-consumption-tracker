import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/screens/authentication/authentication_content.dart';
import 'package:mediaconsumptiontracker/screens/home/home_content.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeContent(),
    );
  }
}
