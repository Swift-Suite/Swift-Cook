import 'package:flutter/material.dart';
import 'package:swiftcook/model/recipe.dart';

class RecipeDetails extends StatelessWidget {
  RecipeDetails({@required this.recipe});

  final Recipe recipe;

  Widget _buildIngredientList() {
    return Container(
        child: ListView.separated(
            itemCount: recipe.ingredientList.length + 1,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                // return a header
                return Row(children: [
                  Text("Quantity"),
                  Text("Unit"),
                  Text("Ingredient"),
                ]);
              }
              index -= 1;

              var data = recipe.ingredientList[index];
              return Row(children: [
                Text(data.title),
                Text(data.quantity.toString()),
                Text(data.unit)
              ]);
            }),
        height: 400);
  }

  Widget _buildInstructionList() {
    return Container(child: Text("hello"));
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
