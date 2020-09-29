import 'package:flutter/material.dart';

Future<bool> confirmationAlert(BuildContext context){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are You Sure About That"),

            content: Text("Recipe will be permanently deleted, proceed?", style: TextStyle(fontSize: 14)),
            actions :<Widget> [
              MaterialButton(
                elevation:5.0,
                child:Text('Confirm', style: TextStyle(color: Colors.blue)),
                onPressed:(){
                  Navigator.of(context).pop(true);
                },
              ),
              MaterialButton(
                elevation:5.0,
                child: Text("Cancel", style: TextStyle(color: Colors.blue)),
                onPressed: (){
                  Navigator.of(context).pop(false);
                }
              )
            ]

          );
        });
  }