// Author: @tdimhcsleumas

import 'package:flutter/material.dart';
import '../model/data_objects/serializable.dart';

class SerializableList extends StatelessWidget {
  SerializableList(this.serializables);

  List<Serializable> serializables;

  @override
  Widget build(BuildContext context) {
    //main column
    List<Widget> cBuilder = List<Widget>();

    //constructs the
    bool divider = false;
    for (int i = 0; i<serializables.length;i++) {
      var data = serializables[i].jsonSerialize();
      //builds the item to be added to the item builder.
      List<Widget> content = List<Widget>();
      content.add(Icon(Icons.arrow_right));
      content.add(VerticalDivider());

      content.addAll(data.values.map((value) {
        return Expanded(child: Text(value.toString()));
      }).toList());

      //adds the row to the column builder
      cBuilder.add(Row(children: content));
      divider = !divider;
      if(divider &&  i != serializables.length-1){
        cBuilder.add(Divider());
        divider = !divider;
      }
    }

    Size size = MediaQuery.of(context).size;
    print(serializables.length);
    return Container(
        child: Column(
          children: cBuilder,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.lightBlueAccent,
        ));
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
