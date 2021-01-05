import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetails extends StatelessWidget {
  static const routeName = '/meal-details';

  final Function isFavourite;
  final Function addFavouriteHandler;

  MealDetails(this.isFavourite, this.addFavouriteHandler);

  List<Widget> _buildSectionTitle(BuildContext ctx, String title) {
    return [
      const SizedBox(
        height: 10,
      ),
      Text(
        '$title',
        style: Theme.of(ctx).textTheme.title,
      ),
    ];
  }

  Widget _buildSectionItem(BuildContext ctx, Widget child) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Meal>;
    final mealDetail = routeArgs['meal_detail'];
    return Scaffold(
      body: SafeArea(
        top: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    '${mealDetail.title}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  background: Image.network(
                    mealDetail.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ..._buildSectionTitle(context, 'Ingredients'),
                _buildSectionItem(
                    context,
                    ListView(
                      children: mealDetail.ingredients.map((ingredient) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: Text(
                                  '$ingredient',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                ..._buildSectionTitle(context, 'Steps'),
                _buildSectionItem(
                  context,
                  ListView.builder(
                    itemBuilder: (_, index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                mealDetail.steps[index],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    },
                    itemCount: mealDetail.steps.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavourite(mealDetail.id)
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
        onPressed: () {
          //Navigator.of(context).pop(mealDetail.id);
          addFavouriteHandler(mealDetail.id);
        },
      ),
    );
  }
}
