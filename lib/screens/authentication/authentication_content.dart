import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/screens/authentication/views/home_view.dart';
import 'package:mediaconsumptiontracker/screens/authentication/views/login_view.dart';
import 'package:mediaconsumptiontracker/screens/authentication/views/register_view.dart';

class AuthenticationContent extends StatefulWidget {
  @override
  _AuthenticationContentState createState() => new _AuthenticationContentState();
}

class _AuthenticationContentState extends State<AuthenticationContent>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            LoginView(
              onBackPressed: _gotoHome,
              onSignUpPressed: _gotoRegister,
            ),
            HomeView(
              onLoginPressed: _gotoLogin,
              onSignUpPressed: _gotoRegister,
            ),
            RegisterView(
              onBackPressed: _gotoHome,
              onLoginPressed: _gotoLogin,
            )
          ],
          scrollDirection: Axis.horizontal,
        ));
  }

  void _gotoLogin() {
    _controller.animateToPage( 0,
      duration: Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _gotoRegister() {
    _controller.animateToPage( 2,
      duration: Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _gotoHome() {
    _controller.animateToPage( 1,
      duration: Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
