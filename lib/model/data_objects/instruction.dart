// Author: @tdimhcsleumas
import 'package:sqflite/sqflite.dart';
import './serializable.dart';
import '../database_manager.dart';
import '../../swift_exception.dart';

class Instruction extends Serializable {
  // sql strings ===============================================================
  static const String SQL_INSERT = '''
  INSERT INTO Instruction (RecipeId, Content)
  VALUES (?,?);
  ''';

  static const String SQL_SELECT = '''
  SELECT
    rowid, RecipeId, Content
  FROM
    Instruction
  ''';

  static const String SQL_UPDATE = '''
    UPDATE Instruction
    Set
      RecipeId = ?,
      Content = ?
    Where
      rowid = ?
  ''';

  static const String SQL_DELETE = '''
  DELETE FROM Instruction WHERE rowid = ?
  ''';

  static const String SQL_WHERE_RECIPE_ID = '''RecipeId = ?''';
  static const String SQL_WHERE_ROWID = '''rowid = ?''';

  // class meta data ===========================================================
  static const String TAG = "Instruction";
  static const String kId = "rowid";
  static const String kRecipeId = "RecipeId";
  static const String kContent = "Content";

  static final List<String> _keyList = [kId, kRecipeId, kContent];

  int id;
  int recipeId;
  String content;

  // class creation ============================================================
  Instruction._(); // private default ctor
  // id should just get filled in by sql as we operate on this object
  Instruction(this.recipeId, this.content);

  @override
  void initializeFromJson(Map<String, dynamic> json) {
    this.id = json[Instruction.kId] ?? null;
    this.recipeId = json[Instruction.kRecipeId] ?? null;
    this.content = json[Instruction.kContent] ?? null;
  }

  static Instruction createFromJson(Map<String, dynamic> json) {
    Instruction instruction = new Instruction._();
    instruction.initializeFromJson(json);

    return instruction;
  }

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {kId: this.id, kRecipeId: this.recipeId, kContent: this.content};
  }

  // retrieves =================================================================
  // TODO: @tdimhcsleumas all of these retrieves can probably be cleaned up
  // to avoid code repetition
  static Future<Instruction> retrieveByRowId(int rowid) async {
    Database db = await DatabaseManager.instance.database;

    String whereList = SQL_WHERE_ROWID;
    String sql = SQL_SELECT + " WHERE " + whereList;

    var result = await db.rawQuery(sql, [rowid]);

    return result != null && result.length > 0
        ? Instruction.createFromJson(result[0])
        : null;
  }

  static Future<List<Instruction>> retrieveByRecipeId(int recipeId) async {
    Database db = await DatabaseManager.instance.database;

    String whereList = SQL_WHERE_RECIPE_ID;
    String sql = SQL_SELECT + " WHERE " + whereList;

    var result = await db.rawQuery(sql, [recipeId]);

    return result.map((row) => Instruction.createFromJson(row)).toList();
  }

  static Future<List<Instruction>> retrieveAll() async {
    Database db = await DatabaseManager.instance.database;

    var result = await db.rawQuery(SQL_SELECT);

    return result.map((row) => Instruction.createFromJson(row)).toList();
  }

  // insert ====================================================================
  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    this.id = await db.rawInsert(SQL_INSERT, [this.recipeId, this.content]);
    return this.id;
  }

  // update ====================================================================
  Future<bool> dbUpdate() async {
    Database db = await DatabaseManager.instance.database;
    int count =
        await db.rawUpdate(SQL_UPDATE, [this.recipeId, this.content, this.id]);

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
