import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import '../model/data_objects/recipe.dart';
import './recipes_details.dart';
import './recipes_page_widgets/recipe_card.dart';

class RecipesPage extends StatefulWidget {
  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {
  bool canEdit = false;

  void toggleEdit() {
    setState(() {
      canEdit = !canEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Master"),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => setState(() {
                canEdit = !canEdit;
              }),
            ),
          ],
        ),
        body: RecipeListing(recipeSelectedCallback: (recipe) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (BuildContext context) {
                return RecipeDetails(recipe: recipe);
              },
            ),
          );
        }));
  }
}

/** list view for all the recipes */
class RecipeListing extends StatelessWidget {
  const RecipeListing(
      {@required this.recipeSelectedCallback, this.selectedRecipe});

  final ValueChanged<Recipe> recipeSelectedCallback;
  final Recipe selectedRecipe;

  @override
  Widget build(BuildContext context) {
    //double containerHeight = Recipe.getTestData().length *10.0;
    int recipeLength = Recipe.getTestData().length;
    List<Recipe> recipe = Recipe.getTestData();
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: recipeLength + 1,
        itemBuilder: (BuildContext ctxt, int index) {
          if (index < recipeLength) {
            return RecipeCard(
                recipe: recipe[index],
                recipeSelectedCallback: recipeSelectedCallback);
            // return ListTile(
            //     title: Text(recipe[index].title),
            //     onTap: () => recipeSelectedCallback(recipe[index]),
            //     selected: selectedRecipe == recipe[index]);
          } else {
            int Reeee = 0;
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              IconButton(
                icon: Icon(Icons.add, size: 18),
                tooltip: 'Add More Recipes',
                color: Colors.green,
                onPressed: () {
                  Reeee += 1;
                  print('$Reeee');
                },
              ),
            ]);
          }
        });
  }
}
