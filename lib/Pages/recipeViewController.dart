import 'package:flutter/material.dart';
import '../model/data_objects/recipe.dart';
import '../components/serializable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:swiftcook/Pages/edit_page.dart';
import 'package:swiftcook/Pages/recipes_details.dart';

class RecipeViewController extends StatefulWidget{
  final Recipe recipe;
  const RecipeViewController({ Key key, this.recipe }): super(key: key);

  State<RecipeViewController> createState() => RecipeViewControllerState();

}

class RecipeViewControllerState extends State<RecipeViewController>{
  bool editable = false;

  void toggleEdit(){
    setState((){
    this.editable = !this.editable;
    });
  }

  @override
  Widget build(BuildContext context){
    Widget viewBody;
    Widget currentButton;
    if(editable){
      viewBody =  EditPage(recipe:widget.recipe);
      currentButton = FlatButton(onPressed: toggleEdit, child: Text("Save"));
    }
    else{
      viewBody =  RecipeDetails(recipe:widget.recipe);
      currentButton = IconButton(icon: Icon(Icons.edit), onPressed: toggleEdit);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
        actions: [currentButton],
      ),
      body: viewBody 
    );
    
  }
}