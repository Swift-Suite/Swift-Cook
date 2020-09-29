import 'package:flutter/material.dart';
import 'package:swiftcook/model/data_objects/recipe.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
//import 'package:swiftcook/model/data_objects/instruction.dart';

class EditPage extends StatefulWidget {
  final Recipe recipe;
  EditPage({Key key, this.recipe}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    //main column
    List<Ingredient> ingredientList = widget.recipe.ingredientList;

    List<Widget> cBuilder = List<Widget>();

    Size size = MediaQuery.of(context).size;
    bool divider = false;
    for (int i = 0; i < ingredientList.length; i++) {
      Ingredient data = ingredientList[i];
      //builds the item to be added to the item builder.

      //adds the row to the column builder
      cBuilder.add(IngredientRow(ingredient: data, controller: null, size: size));
      divider = !divider;
      if (divider && i != ingredientList.length - 1) {
        cBuilder.add(Divider());
        divider = !divider;
      }
    }

    //print(serializables.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: ListView(
        children:<Widget>[ Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left:5, right:5),
                child: Column(
                  children: cBuilder,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.lightBlueAccent,
              )),
        ),
      ]),
    );
  }
}

class IngredientRow extends StatefulWidget {
  final Ingredient ingredient;
  final TextEditingController controller;
  final Size size;
  IngredientRow({Key key,@required this.ingredient, @required this.controller, @required this.size}) : super(key: key);
  @override
  _IngredientRowState createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Container(
          child: Icon(Icons.edit, size:15),
          width: widget.size.width/12,
        ),
        Expanded(
          child: TextFormField(
            initialValue: widget.ingredient.title,
            decoration: new InputDecoration(
              border: OutlineInputBorder(),
            ),
            style: TextStyle(fontSize: 10),

            //controller: widget.controller,
          )
        ),
        Container( //quanity
          child: TextFormField(
            initialValue: widget.ingredient.quantity.toString(),
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
              ),
            style: TextStyle(fontSize: 10),
          ),
          width: widget.size.width/10

        ),
        Container( //unit of measure
          child: UnitDropDown(initial: widget.ingredient.unit),
            width: widget.size.width/10


        ),
      ]
    );
  }
}

class UnitDropDown extends StatefulWidget {
  final String initial;
  UnitDropDown({Key key, this.initial}) : super(key: key);

  @override
  _UnitDropDownState createState() => _UnitDropDownState();
}

class _UnitDropDownState extends State<UnitDropDown>{
  @override
  Widget build(BuildContext context){
    String dropDownValue = widget.initial;
    return DropdownButton<String>(
      value:dropDownValue,
      //icon: Icon(Icons.more_vert),
      elevation: 16,
      style: TextStyle(color: Colors.black,fontSize: 10),
      onChanged: (String newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
      items: <String>['ml','L', 'C', 'g', 'kg','lb','oz', 'pt', 't','T']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize:10)),
        );
      }).toList(),
    );
  }

}
