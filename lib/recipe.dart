import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SavedRecipe extends StatefulWidget {
  @override
  SavedRecipeState createState() => SavedRecipeState();
}

class SavedRecipeState extends State<SavedRecipe> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "SavedRecipe",
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
