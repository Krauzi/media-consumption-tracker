import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mediaconsumptiontracker/blocs/auth_bloc.dart';
import 'package:mediaconsumptiontracker/enums/search_type.dart';
import 'package:mediaconsumptiontracker/screens/home/views/books_edit.dart';
import 'package:mediaconsumptiontracker/screens/home/views/books_view.dart';
import 'package:mediaconsumptiontracker/screens/home/views/games_edit.dart';
import 'package:mediaconsumptiontracker/screens/home/views/games_view.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_search.dart';
import 'package:mediaconsumptiontracker/screens/home/views/movies_view.dart';
import 'package:mediaconsumptiontracker/screens/home/views/series_view.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/app_drawer.dart';
import 'package:mediaconsumptiontracker/screens/home/widgets/custom_fab.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';
import 'package:mediaconsumptiontracker/utils/navbar_icons.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin  {

  AuthBloc _authBloc;

  StreamSubscription _currentUser;
  String userId;

  TabController tabBarController;
  List<Tabs> tabs = new List();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.getBloc();

    _currentUser = _authBloc.userLoggedObservable.listen((user) {
      userId = user.uid;
    });

    tabs.add(Tabs(MyFlutterApp.games, "Games", Colors.deepPurple, getGradient(Colors.deepPurple)));
    tabs.add(Tabs(MyFlutterApp.books, "Books", Colors.pink, getGradient(Colors.pink)));
    tabs.add(Tabs(MyFlutterApp.movies, "Movies", Colors.amber, getGradient(Colors.amber)));
    tabs.add(Tabs(Icons.live_tv, "Series", Colors.deepOrangeAccent, getGradient(Colors.deepOrangeAccent)));

    tabBarController = TabController(initialIndex: _currentIndex, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _whichAdd(context, _currentIndex),
      drawer: AppDrawer(logout: _logOut),
      body: StreamBuilder(
        stream: _authBloc.userLoggedObservable,
        builder: (context, snap) {
          if (snap.hasData) {
            return TabBarView(
              controller: tabBarController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GamesView(userId: userId),
                BooksView(userId: userId),
                MoviesView(userId: userId),
                SeriesView(userId: userId),
              ],
            );
          } else return SpinKitChasingDots(
              color: applicationColors['pink'],
              size: MediaQuery.of(context).size.width * 0.2,
          );
        },
      ),
      bottomNavigationBar: CubertoBottomBar(
        barBackgroundColor: applicationColors['pink'],
        inactiveIconColor: applicationColors['white'],
        tabStyle: CubertoTabStyle.STYLE_NORMAL,
        textColor: applicationColors['black'],
        selectedTab: _currentIndex,
        tabs: tabs
            .map((value) => TabData(
            iconData: value.icon,
            title: value.title,
            tabColor: value.color,
            tabGradient: value.gradient))
            .toList(),
        onTabChangedListener: (position, title, color) {
          setState(() {
            tabBarController.animateTo(position);
            _currentIndex = position;
          });
        },
      ),
    );
  }

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
            builder: (_) => GamesEdit(userId: userId, buttonText: "Add game",)
        )
      );
    } else if (page == 1) {
      return CustomFAB(
          icon: Icons.add,
          onPressed: () => showDialog(
              context: context,
              builder: (_) => BooksEdit(userId: userId, buttonText: "Add book")
          )
      );
    } else if (page == 2) {
      return CustomFAB(
          icon: Icons.search,
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MoviesSearch(
                searchType: SearchType.MOVIE, userId: userId,)))
      );
    } else {
      return CustomFAB(
          icon: Icons.search,
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MoviesSearch(
                searchType: SearchType.SERIES, userId: userId,)))
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _currentUser.cancel();
  }
}



class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient gradient;

  Tabs(this.icon, this.title, this.color, this.gradient);
}

  getGradient(Color color) {
    return LinearGradient(
        colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
        stops: [0.0, 0.7]);
  }