import 'package:flutter/material.dart';

class MealMetaData extends StatelessWidget {
  final IconData image;
  final String title;

  MealMetaData(this.image, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            image,
            color: Colors.black54,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            '$title',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
