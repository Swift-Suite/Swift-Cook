import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';
import 'package:swiftcook/model/data_objects/recipe.dart';
import 'package:swiftcook/swift_exception.dart';

import '../lib/model/database_manager.dart';

void main() async {
  test('ingredients should work lol', ingredientTest);
  test('instruction should work lol', instructionTest);
  test('recipe should work lol', recipeTest);
}

Future<void> ingredientTest() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool error = false;

  Database db = await DatabaseManager.instance.database;
  db.rawDelete("DELETE FROM Ingredient WHERE rowid > 0");

  try {
    Ingredient ingredient = new Ingredient(0, "Curry", 10, "grams");

    print("====== testing dbInsert ======");
    int result = await ingredient.dbInsert();
    print(result);

    print("====== testing retrieves ======");

    print("by all: ");
    var list = await Ingredient.retrieveAll();
    print(list);

    print("by recipeId:");
    print(await Ingredient.retrieveByRecipeId(ingredient.recipeId));

    print("by rowid");
    print(await Ingredient.retrieveByRowid(ingredient.id));

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

    var afterDelete = await Ingredient.retrieveAll();
    if (afterDelete.length != 0) throw Exception("delete failed");
  } catch (e) {
    if (e is BaseException) {
      print(e.cause);
    }

    print(e);
    error = true;
  }

  expect(error, false);
}

Future<void> instructionTest() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool error = false;
  Database db = await DatabaseManager.instance.database;
  db.rawDelete("DELETE FROM Instruction WHERE rowid > 0");

  try {
    Instruction instruction = new Instruction(0, "flip the borgar");

    print("====== testing dbInsert Instruction ======");
    int result = await instruction.dbInsert();
    print(result);

    print("====== testing retrieves ======");
    var list = await Instruction.retrieveAll();
    print(list);

    list = await Instruction.retrieveByRecipeId(instruction.recipeId);
    print(list);

    var record = await Instruction.retrieveByRowId(instruction.id);
    expect(record.jsonSerialize(), instruction.jsonSerialize());

    print("====== testing dbUpdate Instruction ======");
    instruction.content = "Toucha the spaghet";
    bool updateResult = await instruction.dbUpdate();
    list = await Instruction.retrieveAll();
    print(list);

    print("====== testing dbDelete Instruction ======");
    bool deleteResult = await instruction.dbDelete();
    if (!deleteResult) throw Exception("delete did not return true");

    print(await Instruction.retrieveAll());
  } catch (e) {
    if (e is BaseException) {
      print(e.cause);
    }

    print(e);
    error = true;
  }
  expect(error, false);
}

Future<void> recipeTest() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool error = false;

  Database db = await DatabaseManager.instance.database;
  db.rawDelete("DELETE FROM Instruction WHERE rowid > 0");

  try {
    Recipe instruction = new Recipe("title", "img.png", [], []);

    print("====== testing dbInsert Recipe ======");
    int result = await instruction.dbInsert();
    print(result);

    print("====== testing retrieves ======");
    var list = await Recipe.retrieveAll();
    print(list);

    var record = await Recipe.retrieveByRowId(instruction.id);
    expect(record.jsonSerialize(), instruction.jsonSerialize());

    print("====== testing dbUpdate Recipe ======");
    instruction.title = "Toucha the spaghet";
    bool updateResult = await instruction.dbUpdate();
    list = await Recipe.retrieveAll();
    print(list);

    print("====== testing dbDelete Recipe ======");
    bool deleteResult = await instruction.dbDelete();
    if (!deleteResult) throw Exception("delete did not return true");

    print(await Recipe.retrieveAll());
  } catch (e) {
    if (e is BaseException) {
      print(e.cause);
    }

    print(e);
    error = true;
  }
  expect(error, false);
}
