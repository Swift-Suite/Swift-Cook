// Author: @tdimhcsleumas
import 'package:sqflite/sqflite.dart';
import './serializable.dart';
import '../database_manager.dart';

class Instruction extends Serializable {
  static const String SQL_INSERT = '''''';
  static const String SQL_SELECT = '''''';
  static const String SQL_UPDATE = '''''';
  static const String SQL_DELETE = '''''';

  static const String kId = "rowid";
  static const String kRecipeId = "recipeId";
  static const String kContent = "content";
  static const List<String> _keyList = [kContent];

  int id;
  int recipeId;
  String content;

  // id should just get filled in by sql as we operate on this object
  Instruction(this.recipeId, this.content);

  static Future<List<Instruction>> retrieveByRecipeId(int recipeId) async {
    return [];
  }

  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    return db.rawInsert(SQL_INSERT, [this.recipeId, this.content]);
  }

  Future<bool> dbUpdate() async {
    return true;
  }

  Future<bool> dbDelete() async {
    return true;
  }

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {kContent: this.content};
  }
}