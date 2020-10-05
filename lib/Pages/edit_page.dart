import 'package:flutter/material.dart';
import 'package:swiftcook/model/data_objects/recipe.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
//import 'package:swiftcook/model/data_objects/instruction.dart';

class IngredientController{
  IngredientController(int recipeID, TextEditingController nameController, String nameInitial, TextEditingController quantityController, String quantityInitial, String unit){
    this.recipeID = recipeID;
    this.nameController = nameController;
    nameController.text = nameInitial;
    this.quantityController = quantityController;
    quantityController.text = quantityInitial;
    this.unit = unit;
  }
  int recipeID;
  TextEditingController nameController;
  TextEditingController quantityController;
  String unit;
}
class EditPage extends StatefulWidget {
  final Recipe recipe;
  EditPage({Key key, this.recipe}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

   List<IngredientController> _controllers = List<IngredientController>();

  @override
  void initState(){
    super.initState();
    List<Ingredient> ingredientList = widget.recipe.ingredientList;
    for(int i =0; i<ingredientList.length;i++){
      IngredientController controller = IngredientController(ingredientList[i].recipeId,TextEditingController(), ingredientList[i].title, TextEditingController(), ingredientList[i].quantity.toString(), ingredientList[i].unit);
      _controllers.add(controller);
    }
  }

  void constructNewIngredients(){
      List<Ingredient> newIngredients = List<Ingredient>();
      for(IngredientController x in _controllers){
        newIngredients.add(Ingredient(x.recipeID,x.nameController.text, double.parse(x.quantityController.text), x.unit));
        print(x.nameController.text);
      }
    }

  Widget build(BuildContext context) {
    //main column
    List<Widget> cBuilder = List<Widget>();
    
    void addNewIngredient(){
      print("adding");
      setState((){
        //ingredientList.add(Ingredient(widget.recipe.id,"PLACEHOLDER", 1.0, "ml" ));
        _controllers.add(IngredientController(widget.recipe.id,TextEditingController(), "", TextEditingController(), "1.0" .toString(), "ml"));
      });
    }
    void removeIngredient(int index){
      print("removing");
      setState((){
        //ingredientList.removeAt(index);
        _controllers.removeAt(index);
      });
    }

    Size size = MediaQuery.of(context).size;
    bool divider = false;
    for (int i = 0; i < _controllers.length; i++) {
      //Controller Settings;
      //adds the row to the column builder
      cBuilder.add(IngredientRow(ingredientController: _controllers[i],size: size, index:i,removeAt: removeIngredient, ));
      divider = !divider;
      if (divider && i != _controllers.length - 1) {
        cBuilder.add(Divider());
        divider = !divider;
      }
    }

    //print(serializables.length);
    return ScrollConfiguration(
        behavior: new ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView(
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
            IconButton(
              icon: Icon(Icons.add, size: 18),
              tooltip: 'Add More Ingredients',
              color: Colors.green,
              onPressed: () {
                addNewIngredient();
              },
            ),
        ]),
    );
  }


}

class IngredientRow extends StatefulWidget {
  final Size size;
  final ingredientController;
  final int index;
  final Function removeAt;
  IngredientRow({Key key,this.ingredientController,this.index, this.size, this.removeAt}) : super(key: key);
  @override
  _IngredientRowState createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.ingredientController.unit;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color:Colors.red,
        child: Icon(Icons.cancel),
      ),
      //secondaryBackground: Container(
        //color: Colors.red,
        //child: Icon(Icons.cancel)
      //),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        print(widget.index);
        widget.removeAt(widget.index);
      },
      child: Row(
        children:[
          Container(
            child: Icon(Icons.edit, size:15),
            width: widget.size.width/12,
          ),
          Expanded(
            child: TextFormField(
              controller: widget.ingredientController.nameController,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 10),
            )
          ),
          Container( //quanity
            padding: const EdgeInsets.symmetric(vertical:5, horizontal:5),
            child: TextFormField(
              keyboardType: TextInputType.number,
                controller: widget.ingredientController.quantityController,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                ),
              style: TextStyle(fontSize: 10),
            ),
            width: widget.size.width/8

          ),
          Container( //unit of measure
              padding: const EdgeInsets.symmetric(vertical:5, horizontal:5),
              child: DropdownButton<String>(
                value:dropDownValue,
                //icon: Icon(Icons.more_vert),
                elevation: 16,
                style: TextStyle(color: Colors.black,fontSize: 10),
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValue = newValue;
                    widget.ingredientController.unit = newValue;
                  });
                },
                items: <String>['ml','L', 'C', 'g', 'kg','lb','oz', 'pt', 't','T']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize:10)),
                  );
                }).toList(),
              ),
              width: widget.size.width/8

          ),
          Container()

        ]
      ),
    );
  }
}
