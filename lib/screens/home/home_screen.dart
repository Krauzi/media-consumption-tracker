import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/screens/home/home_content.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/AppDrawer.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/navbar_icons.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  PageController _pageController;
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.getBloc();
    _pageController = PageController(initialPage: 0, viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: applicationColors['pink'],
        elevation: 0,
      ),
      drawer: AppDrawer(logout: _logOut,),
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeContent(),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
          ],
        ),
      bottomNavigationBar: BottomNavyBar(
          backgroundColor: applicationColors['pink'],
          selectedIndex: _currentIndex,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: barItems
      ),
    );
  }

  List<BottomNavyBarItem> barItems = [
    BottomNavyBarItem(
        title: Text('Games'),
        icon: Icon(MyFlutterApp.games),
        activeColor: applicationColors['purple'],
        inactiveColor: applicationColors['white'],
        textAlign: TextAlign.center
    ),
    BottomNavyBarItem(
        title: Text('Books'),
        icon: Icon(MyFlutterApp.books),
        activeColor: applicationColors['purple'],
        inactiveColor: applicationColors['white'],
        textAlign: TextAlign.center
    ),
    BottomNavyBarItem(
        title: Text('Movies'),
        icon: Icon(MyFlutterApp.movies),
        activeColor: applicationColors['purple'],
        inactiveColor: applicationColors['white'],
        textAlign: TextAlign.center
    ),
  ];

  void _logOut() {
    _authBloc.logOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }
}