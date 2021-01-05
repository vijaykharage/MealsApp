import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../assets/category_data.dart';

import '../models/meal.dart';

class MealsScreen extends StatefulWidget {
  /// Removed this to use named route
  // final String title;

  // MealsScreen(this.title);

  static const routeName = '/meals-screen';
  final List<Meal> mealList;

  MealsScreen(this.mealList);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  var _didSetData = false;
  String title;
  List<Meal> categoryMeals;

  /// calls right after initState(), calls multiple times after initState().
  /// Triggers whenever reference of State changes
  /// Here we can't get routeArgs using context in initState() method bcoz
  /// initState() will call too early before build(), this we could not get
  /// context instance in initState(). so we are using
  /// didChangeDependencies method to set our data one time.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didSetData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      title = routeArgs['title'];
      final String id = routeArgs['id'];

      categoryMeals = widget.mealList.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      _didSetData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(categoryMeals[index]);
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }

  void _removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }
}
