import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditPage extends StatefulWidget {
  @override
  EditPageState createState() => EditPageState();
}

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('This is to see if the button works.'),
        ),
        body: const Center(
          child: Text(
            'LOLOLOL',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

class EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              openPage(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
    );
  }
}
