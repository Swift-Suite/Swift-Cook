import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import '../model/data_objects/recipe.dart';
import './recipes_details.dart';
import '../components/recipe_card.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';

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
class RecipeListing extends StatefulWidget {
  final recipeSelectedCallback;
  final selectedRecipe;

  RecipeListing(
    {@required this.recipeSelectedCallback, this.selectedRecipe}
  );
  RecipeListingState createState() => RecipeListingState(this.recipeSelectedCallback, this.selectedRecipe);
}

class RecipeListingState extends State<RecipeListing>{
  final ValueChanged<Recipe> recipeSelectedCallback;
  final Recipe selectedRecipe;
  RecipeListingState(this.recipeSelectedCallback, this.selectedRecipe);

  List<Recipe> allRecipes = Recipe.getTestData();

  @override
  Widget build(BuildContext context) {
    //double containerHeight = Recipe.getTestData().length *10.0;
    int recipeLength = allRecipes.length;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: recipeLength + 1,
        itemBuilder: (BuildContext ctxt, int index) {
          if (index < recipeLength) {
            return RecipeCard(
                recipe: allRecipes[index],
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
                  addNewRecipe();
                },
              ),
            ]);
          }
        });
  }

  void addNewRecipe(){
      Recipe placehold = Recipe("PLACEHOLDER TITLE", "img.png",
      [Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),
        Ingredient(0,"code", 1.0, "ml"),

       Ingredient(0,"code", 1.0, "ml")],
      [Instruction(0,"talsdfjda;kjfl;skdjf;lkjdsflkjasdkl;fjklsdajfkjdsalkfjadsklfjkdsajfkl;jdsaklfjaklds;fjkadsjfkdsjf;kljsd;klfjdskfjkdsajfkljsa;")]);

      setState((){allRecipes.add(placehold);});

      //database.add(placehold)
  }
}
