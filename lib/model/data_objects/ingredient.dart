// Author: @tdimhcsleumas
import 'package:flutter/material.dart';

import './serializable.dart';
import '../database_manager.dart';
import 'package:sqflite/sqflite.dart';
import '../../swift_exception.dart';

class Ingredient extends Serializable {
  static const String TAG = "Ingredient";
  // const strings to be used by the sql calls
  static const String SQL_INSERT = '''
  INSERT INTO Ingredient (RecipeId, Title, Quantity, Unit)
  VALUES (?,?,?,?)
  ''';

  static const String SQL_SELECT = '''
  SELECT
    rowid, RecipeId, Title, Quantity, Unit
  FROM
    Ingredient
  ''';

  static const String SQL_UPDATE = '''
  UPDATE Ingredient
  SET Title = ?,
      Quantity = ?,
      Unit = ?
  WHERE 
    rowid = ?
  ''';

  static const String SQL_DELETE = '''
  DELETE FROM Ingredient WHERE rowid = ?
  ''';

  static const String SQL_WHERE_RECIPE_ID = '''WHERE RecipeId = ?''';
  static const String SQL_WHERE_ROWID = '''WHERE rowid = ?''';

  static final String kId = "rowid";
  static final String kRecipeId = "recipeId";
  static final String kTitle = "title";
  static final String kQuantity = "quantity";
  static final String kUnit = "unit";

  static final List<String> _keyList = [
    kId,
    kRecipeId,
    kTitle,
    kQuantity,
    kUnit
  ];

  int id;
  int recipeId;
  String title;
  double quantity;
  String unit;

  Ingredient._();
  Ingredient(this.recipeId, this.title, this.quantity, this.unit);

  static Future<Ingredient> retrieveByRowid(int rowid) async {
    Database db = await DatabaseManager.instance.database;

    var result = await db.rawQuery(SQL_SELECT + SQL_WHERE_ROWID, [rowid]);

    return createFromJson(result[0]);
  }

  static Future<List<Ingredient>> retrieveByRecipeId(int recipeId) async {
    Database db = await DatabaseManager.instance.database;

    var result =
        await db.rawQuery(SQL_SELECT + SQL_WHERE_RECIPE_ID, [recipeId]);

    return result.map((row) => Ingredient.createFromJson(row)).toList();
  }

  static Future<List<Ingredient>> retrieveAll() async {
    Database db = await DatabaseManager.instance.database;

    var result = await db.rawQuery(SQL_SELECT);

    return result.map((row) => Ingredient.createFromJson(row)).toList();
  }

  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    this.id = await db.rawInsert(
        SQL_INSERT, [this.recipeId, this.title, this.quantity, this.unit]);
    return this.id;
  }

  Future<bool> dbUpdate() async {
    Database db = await DatabaseManager.instance.database;
    int count = await db
        .rawUpdate(SQL_UPDATE, [this.title, this.quantity, this.unit, this.id]);

    if (count != 1) {
      throw new DatabaseWriteException(
          TAG, "Invalid query made for dbUpdate. actual count: $count");
    }

    return true;
  }

  Future<bool> dbDelete() async {
    Database db = await DatabaseManager.instance.database;
    int count = await db.rawDelete(SQL_DELETE, [this.id]);

    if (count != 1) {
      throw new DatabaseWriteException(
          TAG, "Invalid query made for dbDelete. actual count: $count");
    }

    return true;
  }

  static Ingredient createFromJson(Map<String, dynamic> json) {
    Ingredient ingredient = new Ingredient._();

    ingredient.id = json[Ingredient.kId] ?? null;
    ingredient.recipeId = json[Ingredient.kRecipeId] ?? null;
    ingredient.title = json[Ingredient.kTitle] ?? null;
    ingredient.quantity = json[Ingredient.kQuantity] ?? null;
    ingredient.unit = json[Ingredient.kUnit] ?? null;

    return ingredient;
  }

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {kTitle: this.title, kQuantity: this.quantity, kUnit: this.unit};
  }
}
