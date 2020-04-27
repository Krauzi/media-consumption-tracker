import 'package:flutter/material.dart';
import 'package:mediaconsumptiontracker/utils/app_colors.dart';

typedef void OnClick();

class AppDrawer extends StatelessWidget {

  final OnClick logout;

  AppDrawer({this.logout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.contacts,
              text: 'Contacts',
              onTap: () => Navigator.pop(context)
          ),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Events',
              onTap: () => Navigator.pop(context)
          ),
          _createDrawerItem(
              icon: Icons.note,
              text: 'Notes',
              onTap: () => Navigator.pop(context)
          ),
          Divider(),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: logout
          )
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: applicationColors['blueish']
        ),
        child: Stack(
            children: <Widget>[
              Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text("User info", textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)
                  )
              ),
            ]
        )
    );
  }

  Widget _createDrawerItem({IconData icon, String text,
    GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}