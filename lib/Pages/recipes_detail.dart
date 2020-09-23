import 'package:flutter/material.dart';
import '../model/recipe.dart';
import '../components/serializable_list.dart';

class RecipeDetails extends StatelessWidget {
  RecipeDetails({@required this.recipe});

  final Recipe recipe;

  Widget _buildIngredientList() {
    return SerializableList(recipe.ingredientList);
  }

  Widget _buildInstructionList() {
    return SerializableList(recipe.instructionList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.title),
          actions: [IconButton(icon: Icon(Icons.edit), onPressed: null)],
        ),
        body: Column(
          children: [_buildIngredientList(), _buildInstructionList()],
        ));
  }
}
