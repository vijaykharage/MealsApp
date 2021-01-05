import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_metadata.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  //final Function removeMealHandler;

  MealItem(this.meal);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      splashColor: Theme.of(context).primaryColor,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: './lib/assets/images/placeholder.jpg',
                    image: meal.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 100),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.black54,
                    width: 200,
                    child: Text(
                      '${meal.title}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MealMetaData(
                    Icons.timer,
                    '${meal.duration} min',
                  ),
                  MealMetaData(
                    Icons.work,
                    '${meal.complexity.toString().split('.').last}',
                  ),
                  MealMetaData(
                    Icons.attach_money,
                    '${meal.affordability.toString().split('.').last}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetails.routeName,
      arguments: {'meal_detail': meal},
    ).then((result) {
      if (result != null) {
        //removeMealHandler(result);
      }
    });
  }
}
