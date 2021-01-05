import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  List<Widget> _makeListTile(String title, Icon icon, Function tapHandler) {
    return [
      ListTile(
        leading: icon,
        title: Text(title),
        onTap: tapHandler,
      ),
      Divider(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                'Cooking Up!!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                  fontSize: 40,
                ),
              ),
            ),
            ..._makeListTile('Meals', Icon(Icons.restaurant), () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
            ..._makeListTile('Settings', Icon(Icons.settings), () {
              Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
