import 'package:flutter/material.dart';
import '../model/data_objects/serializable.dart';
import 'package:swiftcook/model/data_objects/recipe.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';

class EditPage extends StatefulWidget {
  final Recipe recipe;
  EditPage({Key key, this.recipe }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage>{
  @override
  Widget build(BuildContext context) {
    //main column
    List<Ingredient> ingredientList = widget.recipe.ingredientList;

    List<Widget> cBuilder = List<Widget>();

    Size size = MediaQuery.of(context).size;



    //constructs the
    // bool divider = false;
    // for (int i = 0; i < ingredientList.length; i++) {
    //   var data = ingredientList[i];
    //   //builds the item to be added to the item builder.
    //   List<Widget> row = List<Widget>();
    //   row.add(Container(width:size.width/10, child: Icon(Icons.edit)));
    //   row.add(Expanded(child:TextFormField(
    //
    //   )))
    //   //adds the row to the column builder
    //   cBuilder.add(Row(children: row));
    //   divider = !divider;
    //   if (divider && i != ingredientList.length - 1) {
    //     cBuilder.add(Divider());
    //     divider = !divider;
    //   }
    // }

    //print(serializables.length);
    return Scaffold(
      appBar:AppBar(
        title: Text(widget.recipe.title),
      ),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: cBuilder,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.lightBlueAccent,
          )),
    );
  }

// @override
// Widget build(BuildContext context) {
//   double height = MediaQuery.of(context).size.height;
//
//   return Container(
//     child: ListView.separated(
//         itemCount: serializables.length,
//         separatorBuilder: (BuildContext context, int index) => Divider(),
//         itemBuilder: (BuildContext context, int index) {
//           var data = serializables[index].jsonSerialize();
//           List<Widget> content = data.values.map((value) {
//             return Expanded(child: Text(value.toString()));
//           }).toList();
//
//           return Row(children: content);
//         }),
//     padding: const EdgeInsets.all(8.0),
//     height: height / 3,
//   );
// }
}
