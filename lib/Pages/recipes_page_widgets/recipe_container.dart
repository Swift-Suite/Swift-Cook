import 'package:flutter/material.dart';

class RecipeContainer extends StatelessWidget{
  const RecipeContainer({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
            child: 
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Give me da Spaghet Bos"),
                  ),
                  Expanded(
                    child: Text("I love dicks"),
                  )
                ]
              ),
            color: Colors.blue,
            height: 50,
          );
  }
}