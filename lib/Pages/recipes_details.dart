import 'package:flutter/material.dart';
import '../model/data_objects/recipe.dart';
import '../components/serializable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:swiftcook/Pages/edit_page.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [IconButton(icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return EditPage(recipe: recipe);
                  },
                ),
              );
            }
        )],
      ),
      body: ListView(padding: const EdgeInsets.all(8.0), children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(
                left: 40.0,
                top: 10.0,
                right: 10.0,
                bottom: 5.0), //Change to dynamic values
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:
                          Text('Ingredient', style: TextStyle(fontSize: 10))),
                  Container(
                      width: size.width / 10,
                      child: Text(
                        'Quantity',
                        style: TextStyle(fontSize: 10),
                      )),
                  Container(width: 10),
                  Container(
                      width: size.width / 10,
                      child: Text(
                        'Unit',
                        style: TextStyle(fontSize: 10),
                      )),
                ])),
        _buildIngredientList(),
        SizedBox(height: 50),
        Center(child: Text("Instructions", textAlign: TextAlign.center)),
        _buildInstructionList(),
        SizedBox(height: 50),
      ]),
    );
  }
}
