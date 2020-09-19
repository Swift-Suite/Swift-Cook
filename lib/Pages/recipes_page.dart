import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RecipesPage extends StatefulWidget {
  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {
  bool canEdit = false;

  void toggleEdit() {
    setState(() {
      canEdit = !canEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My ReCiPiEs"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => toggleEdit(),
          ),
        ],
      ),
      body: Center(
        child: canEdit == false
            ? Text("Pls Gimme the Spaghet Bos")
            : Text("Pls Don't Gimme the Spaghet Bos"),
      ),
      backgroundColor: Colors.lightBlue[100],
    );
  }
}
