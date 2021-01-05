import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../assets/category_data.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          padding: const EdgeInsets.all(15),
          children: DUMMY_CATEGORIES
              .map(
                (category) => CategoryItem(
                  category.id,
                  category.title,
                  category.color,
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 3 / 2,
          ),
        ),
      ),
    );
  }
}
