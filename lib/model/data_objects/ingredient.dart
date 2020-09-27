// Author: @tdimhcsleumas
import './serializable.dart';
import '../database_manager.dart';
import 'package:sqflite/sqflite.dart';
import '../../swift_exception.dart';

class Ingredient extends Serializable {
  static const String TAG = "Ingredient";
  // const strings to be used by the sql calls
  static const String SQL_INSERT = '''
  INSERT INTO Ingredient (RecipeId, Title, Quantity, Unit)
  VALUES (?,?,?,?);
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
    Id = ?
  ''';

  static const String SQL_DELETE = '''
  DELETE FROM Ingredient WHERE Id = ?
  ''';

  static const String SQL_WHERE_RECIPE_ID = '''WHERE RecipeId = ?''';

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

  Ingredient(this.recipeId, this.title, this.quantity, this.unit);

  // TODO: this later
  static Future<List<Ingredient>> retrieveByRecipeId(int recipeId) async {
    return [];
  }

  // TODO: clean this up mr schmidt
  static Future<List<Map<String, dynamic>>> retrieveAll() async {
    Database db = await DatabaseManager.instance.database;
    return db.rawQuery(SQL_SELECT);
  }

  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    return db.rawInsert(
        SQL_INSERT, [this.recipeId, this.title, this.quantity, this.unit]);
  }

  Future<bool> dbUpdate() async {
    Database db = await DatabaseManager.instance.database;
    int count = await db
        .rawUpdate(SQL_UPDATE, [this.title, this.quantity, this.unit, this.id]);

    if (count != 1) {
      throw new DatabaseWriteException(
          TAG, "More than one row was updated on a dbUpdate");
    }

    return true;
  }

  Future<bool> dbDelete() async {
    Database db = await DatabaseManager.instance.database;
    int count = await db.rawDelete(SQL_DELETE, [this.id]);

    if (count != 1) {
      throw new DatabaseWriteException(
          TAG, "More than one row was updated on a dbDelete");
    }

    return true;
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
