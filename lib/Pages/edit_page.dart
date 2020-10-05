import 'package:flutter/material.dart';
import 'package:swiftcook/model/data_objects/recipe.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';
import 'package:tuple/tuple.dart';

class IngredientController {
  IngredientController(
      int recipeID,
      TextEditingController nameController,
      String nameInitial,
      TextEditingController quantityController,
      String quantityInitial,
      String unit,
      Tuple2<GlobalKey<FormState>, GlobalKey<FormState>> key) {
    this.recipeID = recipeID;
    this.nameController = nameController;
    nameController.text = nameInitial;
    this.quantityController = quantityController;
    quantityController.text = quantityInitial;
    this.unit = unit;
    this.key1 = key.item1;
    this.key2 = key.item2;
  }
  GlobalKey<FormState> key1;
  GlobalKey<FormState> key2;
  int recipeID;
  TextEditingController nameController;
  TextEditingController quantityController;
  String unit;
}

class InstructionController {
  InstructionController(int recipeID, TextEditingController controller,
      GlobalKey<FormState> key) {
    this.controller = controller;
    this.recipeID = recipeID;
    this.key = key;
  }
  GlobalKey<FormState> key;
  int recipeID;
  TextEditingController controller;
}

class EditPage extends StatefulWidget {
  final Recipe recipe;
  EditPage({Key key, this.recipe}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<IngredientController> _ingredientControllers =
      List<IngredientController>();
  List<InstructionController> _instructionControllers =
      List<InstructionController>();
  var ingredientKeys =
      List<Tuple2<GlobalKey<FormState>, GlobalKey<FormState>>>();
  var instructionKeys = List<GlobalKey<FormState>>();

  @override
  void dispose(){
    for(int i = 0; i<_ingredientControllers.length;i++){
      _ingredientControllers[i].nameController.dispose();
      _ingredientControllers[i].quantityController.dispose();
    }
    for(int i = 0; i<_instructionControllers.length;i++){
      _instructionControllers[i].controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    List<Ingredient> ingredientList = widget.recipe.ingredientList;
    for (int i = 0; i < ingredientList.length; i++) {
      var newKey = Tuple2(GlobalKey<FormState>(), GlobalKey<FormState>());
      //Making Ingredient Stuff
      ingredientKeys.add(newKey);
      IngredientController controller = IngredientController(
          ingredientList[i].recipeId,
          TextEditingController(),
          ingredientList[i].title,
          TextEditingController(),
          ingredientList[i].quantity.toString(),
          ingredientList[i].unit,
          newKey);
      _ingredientControllers.add(controller);

    }
    for(int i = 0; i<widget.recipe.instructionList.length;i++){
      //making instruction stuff
      var newKey2 = GlobalKey<FormState>();
      instructionKeys.add(newKey2);
      var newController = TextEditingController();
      newController.text = widget.recipe.instructionList[i].content;
      InstructionController controller2 = InstructionController(
          widget.recipe.instructionList[i].recipeId, newController, newKey2);
      _instructionControllers.add(controller2);
    }
  }

  Widget build(BuildContext context) {
    //main column
    List<Widget> ingredientBuilder = List<Widget>();
    List<Widget> instructionBuilder = List<Widget>();

    void save() {
      List<Ingredient> newIngredients = List<Ingredient>();
      List<Instruction> newInstructions = List<Instruction>();
      for (IngredientController x in _ingredientControllers) {
        newIngredients.add(Ingredient(x.recipeID, x.nameController.text,
            double.parse(x.quantityController.text), x.unit));
        print(x.nameController.text);
      }
      for (var x in _instructionControllers){
        newInstructions.add(Instruction(x.recipeID, x.controller.text ));
        print (x.controller.text);
      }
    }

    void addNewIngredient() {
      print("adding Ingredient");
      setState(() {
        var newKey = Tuple2(GlobalKey<FormState>(), GlobalKey<FormState>());
        ingredientKeys.add(newKey);
        _ingredientControllers.add(IngredientController(
            widget.recipe.id,
            TextEditingController(),
            "",
            TextEditingController(),
            "1.0".toString(),
            "ml",
            newKey));
      });
    }
    void addNewInstruction() {
      print("adding instruction");
      setState((){
        var newKey = GlobalKey<FormState>();
        instructionKeys.add(newKey);
        _instructionControllers.add(InstructionController( widget.recipe.id, TextEditingController(), newKey));
      });

    }
    void removeIngredient(int index) {
      print("removing ingredient");
      setState(() {
        //ingredientList.removeAt(index);
        ingredientKeys.removeAt(index);
        _ingredientControllers.removeAt(index); //Potential memory leak (unsure if unreachable controllers get disposed of).
      });
    }

    void removeInstruction(int index){
      print("removing instruction");
      setState((){
        instructionKeys.removeAt(index);
        _instructionControllers.removeAt(index);
      });
    }

    Size size = MediaQuery.of(context).size;
    bool divider = false;
    for (int i = 0; i < _ingredientControllers.length; i++) {
      //Controller Settings;
      //adds the row to the column builder
      ingredientBuilder.add(IngredientRow(
        ingredientController: _ingredientControllers[i],
        size: size,
        index: i,
        removeAt: removeIngredient,
      ));
      divider = !divider;
      if (divider && i != _ingredientControllers.length - 1) {
        ingredientBuilder.add(Divider());
        divider = !divider;
      }
    }

    bool divider2 = false;
    for (int i = 0; i < _instructionControllers.length; i++) {
      //builds the instructions
      instructionBuilder.add(InstructionRow(
          instructionController: _instructionControllers[i],
          size: size,
          index: i,
        removeAt: removeInstruction,
      ));
      divider2 = !divider2;
      if (divider2 && i != _instructionControllers.length - 1) {
        instructionBuilder.add(Divider());
        divider2 = !divider2;
      }
    }

    //print(serializables.length);
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.title), actions: [
        FlatButton(onPressed: save, child: Text("Save"))
      ]),
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  child: Column(
                    children: ingredientBuilder,
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
          SizedBox(
            height: 25,
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: instructionBuilder,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.lightBlueAccent,
              )),
      IconButton(
          icon: Icon(Icons.add, size: 18),
          tooltip: 'Add More instruction',
          color: Colors.green,
          onPressed: () {
            addNewInstruction(); //change
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
  IngredientRow(
      {Key key,
      this.ingredientController,
      this.index,
      this.size,
      this.removeAt})
      : super(key: key);
  @override
  _IngredientRowState createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.ingredientController.unit;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.cancel),
      ),
      //secondaryBackground: Container(
      //color: Colors.red,
      //child: Icon(Icons.cancel)
      //),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print(widget.index);
        widget.removeAt(widget.index);
      },
      child: Row(children: [
        Container(
          child: Icon(Icons.edit, size: 15),
          width: widget.size.width / 12,
        ),
        Expanded(
            child: TextFormField(
          key: widget.ingredientController.key1,
          controller: widget.ingredientController.nameController,
          decoration: new InputDecoration(
            border: OutlineInputBorder(),
          ),
          style: TextStyle(fontSize: 10),
        )),
        Container(
            //quanity
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: TextFormField(
              key: widget.ingredientController.key2,
              keyboardType: TextInputType.number,
              controller: widget.ingredientController.quantityController,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 10),
            ),
            width: widget.size.width / 8),
        Container(
            //unit of measure
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: DropdownButton<String>(
              value: dropDownValue,
              //icon: Icon(Icons.more_vert),
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 10),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                  widget.ingredientController.unit = newValue;
                });
              },
              items: <String>[
                'ml',
                'L',
                'C',
                'g',
                'kg',
                'lb',
                'oz',
                'pt',
                't',
                'T'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 10)),
                );
              }).toList(),
            ),
            width: widget.size.width / 8),
      ]),
    );
  }
}

class InstructionRow extends StatefulWidget {
  final Size size;
  final instructionController;
  final int index;
  final Function removeAt;
  InstructionRow(
      {Key key,
      this.instructionController,
      this.index,
      this.size,
      this.removeAt})
      : super(key: key);
  @override
  _InstructionRow createState() => _InstructionRow();
}

class _InstructionRow extends State<InstructionRow> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.cancel),
      ),
      //secondaryBackground: Container(
      //color: Colors.red,
      //child: Icon(Icons.cancel)
      //),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print(widget.index);
        widget.removeAt(widget.index);
      },
      child: Row(children: [
        Container(
          child: Icon(Icons.edit, size: 15),
          width: widget.size.width / 12,
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                maxLines: null,
          key: widget.instructionController.key,
          controller: widget.instructionController.controller,
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
          ),
          style: TextStyle(fontSize: 10),
        ),
            )),
      ]),
    );
  }
}
