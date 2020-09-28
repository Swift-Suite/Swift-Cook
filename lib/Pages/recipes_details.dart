import 'package:flutter/material.dart';
import '../model/data_objects/recipe.dart';
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
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left:25.0, top:10.0, right: 10.0, bottom: 5.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Expanded(child:Text('Ingredient')),
              Expanded(child:Text('Unit')),
              Expanded(child:Text('Quantity')),
            ])),
            _buildIngredientList(),

            SizedBox(height:50),
            Center(
                child: Text("Instructions", textAlign: TextAlign.center)
            ),
            _buildInstructionList(),
            SizedBox(height:50),
          ]
        ),
    );
  }
}
