import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'recipes_page_widgets/recipe_container.dart';

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
    //List contains all the recipes.
    List<Widget> recipes = List<Widget>();
    for(int i = 0; i <10; i++){
      recipes.add(RecipeContainer());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("My ReCiPiEs"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => toggleEdit(),
          ),
        ],
      ),
      body: Center(
        child: canEdit == false
            ? ListView.separated(
                itemCount: recipes.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index){
                  return recipes[index];
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              )
            : Text("Pls Don't Gimme the Spaghet Bos 🚷"),
      ),
      backgroundColor: Colors.lightBlue[100],
    );
  }
}
