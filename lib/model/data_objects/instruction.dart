// Author: @tdimhcsleumas
import 'package:sqflite/sqflite.dart';
import './serializable.dart';
import '../database_manager.dart';

class Instruction extends Serializable {
  // sql strings ===============================================================
  static const String SQL_INSERT = '''
  INSERT INFO Instruction (RecipeId, Content)
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
    Set Content = ?,
    Where
      rowid = ?
  ''';

  static const String SQL_DELETE = '''
  DELETE FROM Instruction WHERE rowid = ?
  ''';

  static const String SQL_WHERE_RECIPE_ID = '''WHERE RecipeID = ?''';

  // class meta data ===========================================================
  static const String TAG = "Instruction";
  static const String kId = "rowid";
  static const String kRecipeId = "recipeId";
  static const String kContent = "content";

  static final List<String> _keyList = [kId, kRecipeId, kContent];

  int id;
  int recipeId;
  String content;

  // class creation ============================================================
  Instruction._(); // default ctor
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
    return {kContent: this.content};
  }

  // retrieves =================================================================
  static Future<List<Instruction>> retrieveByRecipeId(int recipeId) async {
    return [];
  }

  // insert ====================================================================
  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    return db.rawInsert(SQL_INSERT, [this.recipeId, this.content]);
  }

  // update ====================================================================
  Future<bool> dbUpdate() async {
    return true;
  }

  // delete ====================================================================
  Future<bool> dbDelete() async {
    return true;
  }
}
