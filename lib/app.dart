import 'package:flutter/material.dart';
import 'Pages/swift_convert_page.dart';
import 'Pages/recipes_page.dart';

class AppState extends State<App> {
  int _currentIndex = 0;
  final List<Widget> _navButtons = <Widget>[
    RecipesPage(),
    SwiftConvertPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navButtons[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   title: Text('Lookup'),
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('Recipes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              title: Text('Convert'),
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.purple[200],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed),
    );
  }
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  AppState createState() => AppState();
}
