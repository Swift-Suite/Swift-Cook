import 'package:flutter/material.dart';
import 'package:swiftcook/model/data_objects/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final ValueChanged<Recipe> recipeSelectedCallback;
  final Function recipeTitleEditCallback;
  final Function recipeDeleteCallback;
  //final Widget thumbnail;
  //constructor
  RecipeCard({
    Key key,
    //this.thumbnail,
    this.recipe,
    this.recipeSelectedCallback,
    this.recipeTitleEditCallback,
    this.recipeDeleteCallback,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            height: size.height / 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.lightBlueAccent,
            ),
            //onPressed: () => recipeSelectedCallback(recipe),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () => recipeSelectedCallback(recipe),
                    child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                  ),
                  Expanded(
                      child: RawMaterialButton(
                          onPressed: () => recipeSelectedCallback(recipe),
                          child: Center(
                              child: Text(recipe.title,
                                  textAlign: TextAlign.center)))),
                  VerticalDivider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        onSelected: (String result){
                          if(result == "Rename"){
                            this.recipeTitleEditCallback(recipe.title, recipe.id); //callback to recipePages to modify the title
                            
                          }
                          else if(result == "Change Image"){

                          }
                          else if(result == "Edit Recipe"){

                          }
                          else if(result == "Delete"){
                            this.recipeDeleteCallback(recipe.id);
                          }
                        },
                        itemBuilder: (BuildContext context){
                          return {'Change Image','Rename','Edit Recipe', 'Delete'}.map((String choice){
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                           }),
                  ),
                ])));
  }
}

// class DropDownMenu extends StatefulWidget {
//   DropDownMenu({Key key}) : super(key: key);
//
//   @override
//   _DropDownMenuState createState() => _DropDownMenuState();
// }
//
// class _DropDownMenuState extends State<DropDownMenu>{
//   String dropdownValue = 'One';
//   @override
//   Widget build(BuildContext context){
//     return DropdownButton<String>(
//       icon: Icon(Icons.more_vert),
//       iconSize: 24,
//       elevation: 16,
//       style: TextStyle(color: Colors.deepPurple),
//       onChanged: (String newValue) {
//         setState(() {
//           dropdownValue = newValue;
//         });
//       },
//       items: <String>['One', 'Two', 'Free', 'Four']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
//
// }
