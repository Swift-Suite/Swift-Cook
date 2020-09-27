import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';

import '../lib/model/database_manager.dart';

void main() {
  test('database should load', () async {
    WidgetsFlutterBinding.ensureInitialized();

    Database db = await DatabaseManager.instance.database;

    Ingredient ingredient = new Ingredient(0, "Curry", 10, "grams");

    print("====== testing dbInsert ======");
    int result = await ingredient.dbInsert();
    print(result);

    var list = await Ingredient.retrieveAll();
    print(list);

    expect(true, true);
  });
}
