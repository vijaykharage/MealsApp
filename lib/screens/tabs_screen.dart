import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../widgets/drawer.dart';
import '../screens/category_screen.dart';
import '../screens/favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'title': 'Categories',
        'page': CategoryScreen(),
      },
      {
        'title': 'My Favourites',
        'page': FavouritesScreen(widget.favouriteMeals),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Android default tab bar
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meal App'),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: "Categories",
    //           ),
    //           Tab(
    //             icon: Icon(Icons.favorite),
    //             text: "Favourites",
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         CategoryScreen(),
    //         FavouritesScreen(),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_currentIndex]['title'],
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: _pages[_currentIndex]['page'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            title: Text('Favourites'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _selectPage,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white54,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
