import 'package:flutter/material.dart';
import '../model/data_objects/serializable.dart';

class SerializableList extends StatelessWidget {
  SerializableList(this.serializables);

  List<Serializable> serializables;

  @override
  Widget build(BuildContext context) {
    //main column
    List<Widget> cBuilder = List<Widget>();

    Size size = MediaQuery.of(context).size;

    //constructs the
    bool divider = false;
    for (int i = 0; i < serializables.length; i++) {
      var data = serializables[i].jsonSerialize();
      //builds the item to be added to the item builder.
      List<Widget> row = List<Widget>();
      row.add(
          Container(width: size.width / 10, child: Icon(Icons.arrow_right)));

      List<dynamic> dataList = data.values.toList();
      for (int i = 2; i < dataList.length; i++) {
        if (i == 2) {
          row.add(Expanded(child: Text(dataList[i].toString())));
        } else {
          row.add(Container(
              width: size.width / 8, child: Text(dataList[i].toString())));
        }
      }

      //adds the row to the column builder
      cBuilder.add(Row(children: row));
      divider = !divider;
      if (divider && i != serializables.length - 1) {
        cBuilder.add(Divider());
        divider = !divider;
      }
    }

    //print(serializables.length);
    return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: cBuilder,
          ),
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
