// Author: @tdimhcsleumas
import 'package:flutter/material.dart';

import './serializable.dart';
import '../database_manager.dart';
import 'package:sqflite/sqflite.dart';
import '../../swift_exception.dart';

import 'dart:core';

class Ingredient extends Serializable {
  // sql strings ===============================================================
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

  static const String SQL_WHERE_RECIPE_ID = '''RecipeId = ?''';
  static const String SQL_WHERE_ROWID = '''rowid = ?''';

  // class meta data ===========================================================
  static const String TAG = "Ingredient";
  static final String kId = "rowid";
  static final String kRecipeId = "RecipeId";
  static final String kTitle = "Title";
  static final String kQuantity = "Quantity";
  static final String kUnit = "Unit";

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

  // class creation ============================================================
  Ingredient._(); // private default ctor
  Ingredient(this.recipeId, this.title, this.quantity, this.unit);

  @override
  void initializeFromJson(Map<String, dynamic> json) {
    this.id = json[Ingredient.kId] ?? null;
    this.recipeId = json[Ingredient.kRecipeId] ?? null;
    this.title = json[Ingredient.kTitle] ?? null;
    this.quantity = json[Ingredient.kQuantity] ?? null;
    this.unit = json[Ingredient.kUnit] ?? null;
  }

  static Ingredient createFromJson(Map<String, dynamic> json) {
    Ingredient ingredient = new Ingredient._();
    ingredient.initializeFromJson(json);

    return ingredient;
  }

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {
      kId: this.id,
      kRecipeId: this.recipeId,
      kTitle: this.title,
      kQuantity: this.quantity,
      kUnit: this.unit
    };
  }

  // retrieves =================================================================
  static Future<Ingredient> retrieveByRowid(int rowid) async {
    Database db = await DatabaseManager.instance.database;

    String whereList = SQL_WHERE_ROWID;
    String sql = SQL_SELECT + " WHERE " + whereList;

    var result = await db.rawQuery(sql, [rowid]);

    return createFromJson(result[0]);
  }

  static Future<List<Ingredient>> retrieveByRecipeId(int recipeId) async {
    Database db = await DatabaseManager.instance.database;

    String whereList = SQL_WHERE_RECIPE_ID;
    String sql = SQL_SELECT + " WHERE " + whereList;

    var result = await db.rawQuery(sql, [recipeId]);

    return result.map((row) => Ingredient.createFromJson(row)).toList();
  }

  static Future<List<Ingredient>> retrieveAll() async {
    Database db = await DatabaseManager.instance.database;

    var result = await db.rawQuery(SQL_SELECT);

    return result.map((row) => Ingredient.createFromJson(row)).toList();
  }

  // create ====================================================================
  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    this.id = await db.rawInsert(
        SQL_INSERT, [this.recipeId, this.title, this.quantity, this.unit]);
    return this.id;
  }

  // update ====================================================================
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

  // delete ====================================================================
  Future<bool> dbDelete() async {
    Database db = await DatabaseManager.instance.database;
    int count = await db.rawDelete(SQL_DELETE, [this.id]);

    if (count != 1) {
      throw new DatabaseWriteException(
          TAG, "Invalid query made for dbDelete. actual count: $count");
    }

    return true;
  }
}
