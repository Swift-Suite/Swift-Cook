import 'package:flutter/material.dart';
import '../model/recipe.dart';

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
              return Container(
                  color: Colors.black12,
                  child: Row(children: [
                    Expanded(child: Text("Quantity")),
                    Expanded(child: Text("Unit")),
                    Expanded(child: Text("Ingredient")),
                  ]));
            }
            index -= 1;

            var data = recipe.ingredientList[index];
            return Row(children: [
              Expanded(child: Text(data.quantity.toString())),
              Expanded(child: Text(data.unit)),
              Expanded(child: Text(data.title)),
            ]);
          }),
      height: 400,
      padding: const EdgeInsets.all(8.0),
    );
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
