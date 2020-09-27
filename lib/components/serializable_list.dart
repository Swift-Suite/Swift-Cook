// Author: @tdimhcsleumas

import 'package:flutter/material.dart';
import '../model/data_objects/serializable.dart';

class SerializableList extends StatelessWidget {
  SerializableList(this.serializables);

  List<Serializable> serializables;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: ListView.separated(
          itemCount: serializables.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            var data = serializables[index].jsonSerialize();
            List<Widget> content = data.values.map((value) {
              return Expanded(child: Text(value.toString()));
            }).toList();

            return Row(children: content);
          }),
      padding: const EdgeInsets.all(8.0),
      height: height / 3,
    );
  }
}
