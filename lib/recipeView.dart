import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RecipeView extends StatefulWidget {
  @override
  RecipeViewState createState() => RecipeViewState();
}

class RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "recipeView",
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
