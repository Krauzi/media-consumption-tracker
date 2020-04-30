import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/screens/home/views/books_add.dart';
import 'package:mediaconsumptiontracker/screens/home/views/books_view.dart';
import 'package:mediaconsumptiontracker/screens/home/views/games_add.dart';
import 'package:mediaconsumptiontracker/screens/home/views/games_view.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_add.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_view.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/app_drawer.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/custom_fab.dart';
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
      floatingActionButton: _whichAdd(context, _currentIndex),
      drawer: AppDrawer(logout: _logOut,),
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            GamesView(),
            BooksView(),
            MoviesView()
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
          items: _barItems,
      ),
    );
  }

  List<BottomNavyBarItem> _barItems = [
    BottomNavyBarItem(
        title: Text('Games'),
        icon: Icon(MyFlutterApp.games),
        activeColor: applicationColors['black'],
        inactiveColor: applicationColors['white'],
        textAlign: TextAlign.center
    ),
    BottomNavyBarItem(
        title: Text('Books'),
        icon: Icon(MyFlutterApp.books),
        activeColor: applicationColors['black'],
        inactiveColor: applicationColors['white'],
        textAlign: TextAlign.center
    ),
    BottomNavyBarItem(
        title: Text('Movies'),
        icon: Icon(MyFlutterApp.movies),
        activeColor: applicationColors['black'],
        inactiveColor: applicationColors['white'],
        textAlign: TextAlign.center
    ),
  ];

  void _logOut() {
    _authBloc.logOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget _whichAdd(BuildContext context, int page) {
    if (page == 0) {
      return CustomFAB(
        icon: Icons.add,
        onPressed: () => showDialog(
            context: context,
            builder: (_) => GamesAdd()
        )
      );
    } else if (page == 1) {
      return CustomFAB(
          icon: Icons.add,
          onPressed: () => showDialog(
              context: context,
              builder: (_) => BooksAdd()
          )
      );
    } else {
      return CustomFAB(
          icon: Icons.search,
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MoviesAdd()))
      );
    }
  }
}