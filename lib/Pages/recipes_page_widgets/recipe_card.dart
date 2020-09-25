import 'package:flutter/material.dart';
import 'package:swiftcook/model/recipe.dart';

class RecipeCard extends StatelessWidget{
  final Recipe recipe;
  final ValueChanged<Recipe> recipeSelectedCallback;
  //final Widget thumbnail;
  //constructor
  RecipeCard({
    Key key,
    //this.thumbnail,
    this.recipe,
    this.recipeSelectedCallback,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Container(
        height: size.height/8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.lightBlueAccent,
        ),
        child: RawMaterialButton(
          //fillColor: Colors.lightBlueAccent,
            onPressed: () => recipeSelectedCallback(recipe),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )

                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,0.0,2.0,0.0),
                        child: Center(
                            child: Text(recipe.title, textAlign: TextAlign.center))
                    )
                )
              ]
          )
        )

      )
    );
  }



}