import 'package:flutter/material.dart';

import './models/meal.dart';

import './assets/category_data.dart';
import './screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/meals_screen.dart';
import './screens/category_screen.dart';

void main() => runApp(MealsApp());

class MealsApp extends StatefulWidget {
  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  Map<String, bool> _filteredData = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  var _mealList = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilteredData(Map<String, bool> setting) {
    setState(() {
      _filteredData = setting;
      _mealList = DUMMY_MEALS.where((meal) {
        if (setting['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (setting['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (setting['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (setting['vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
      _favouriteMeals = [];
    });
  }

  void _toggleFavourite(String mealId) {
    var exisitingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (exisitingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(exisitingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.amberAccent,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              // body1: TextStyle(
              //   color: Color.fromARGB(20, 51, 51, 1),
              // ),
              // body2: TextStyle(
              //   color: Color.fromARGB(20, 51, 51, 1),
              // ),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
      ),

      /// home: CategoryScreen(), // replaced with '/' in routes
      /// initialRoute: '/', // or u can set initial route. default is '/'
      routes: {
        '/': (_) => TabsScreen(_favouriteMeals),
        MealsScreen.routeName: (_) => MealsScreen(_mealList),
        MealDetails.routeName: (_) =>
            MealDetails(_isMealFavorite, _toggleFavourite),
        SettingsScreen.routeName: (_) =>
            SettingsScreen(_filteredData, _setFilteredData),
      },

      /// if the app is accessing unknown route which is not defined in routes:
      /// then this onGenerateRoute: will call default route and act as
      /// fallback option
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => CategoryScreen()); // default route
      },

      /// if routes: and onGenerateRoute: fails to render/create widget object
      /// i.e. not defined at all, then this argument will call
      /// eg. to show 404 page
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => CategoryScreen()); // default route
      },
    );
  }
}
