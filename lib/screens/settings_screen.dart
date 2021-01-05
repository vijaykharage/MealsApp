import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings_screen';

  final Map<String, bool> currentFilter;
  final Function saveHandler;

  SettingsScreen(this.currentFilter, this.saveHandler);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten'];
    _lactoseFree = widget.currentFilter['lactose'];
    _vegetarian = widget.currentFilter['vegetarian'];
    _vegan = widget.currentFilter['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final setting = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
              };
              widget.saveHandler(setting);
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Gluten-Free'),
                  subtitle: Text('Only include gluten-free meal'),
                  value: _glutenFree,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Lactose-Free'),
                  subtitle: Text('Only include lactose-free meal'),
                  value: _lactoseFree,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Vegetarian'),
                  subtitle: Text('Only include vegetarian meal'),
                  value: _vegetarian,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Vegan'),
                  subtitle: Text('Only include vegan meal'),
                  value: _vegan,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
