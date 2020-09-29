import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/swift_exception.dart';

import '../lib/model/database_manager.dart';

void main() {
  test('database should load', () async {
    WidgetsFlutterBinding.ensureInitialized();

    bool error = false;

    Database db = await DatabaseManager.instance.database;
    db.rawDelete("DELETE FROM Ingredient WHERE rowid > 0");

    try {
      Ingredient ingredient = new Ingredient(0, "Curry", 10, "grams");

      print("====== testing dbInsert ======");
      int result = await ingredient.dbInsert();
      print(result);

      var list = await Ingredient.retrieveAll();
      print(list);

      print("====== testing dbUpdate ======");
      ingredient.title = "Paste";
      ingredient.quantity = 15;
      ingredient.unit = "lbs";
      bool updateResult = await ingredient.dbUpdate();
      list = await Ingredient.retrieveAll();
      print(list);

      print("====== testing dbDelete ======");
      bool deleteResult = await ingredient.dbDelete();
      if (!deleteResult) throw Exception("delete did not return true");
    } catch (e) {
      if (e is BaseException) {
        print(e.cause);
      }

      print(e);
      error = true;
    }

    expect(error, false);
  });
}
