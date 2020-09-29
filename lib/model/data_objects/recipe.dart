// Author: @tdimhcsleumas

import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swiftcook/model/data_objects/serializable.dart';
import 'package:swiftcook/model/database_manager.dart';
import '../../swift_exception.dart';

class Recipe extends Serializable {
  // sql strings ===============================================================
  static const String SQL_INSERT = '''
  INSERT INTO Recipe (Title, ImageUrl) 
  Values (?, ?);
  ''';
  //Select might need where statement
  static const String SQL_SELECT = '''
  SELECT
    rowid, Title, ImageUrl
  FROM 
    Recipe
  ''';
  //SQL_Update might need where statement
  static const String SQL_UPDATE = '''
  UPDATE Recipe
  SET Title = ?,
      ImageUrl = ?
  ''';

  static const String SQL_DELETE = '''
  DELETE FROM Recipe WHERE Id = ?
  ''';

  static const String SQL_WHERE_ROWID = '''rowid = ?''';

  // class meta data ===========================================================
  static final String TAG = "Recipe";
  static final String kId = "rowid";
  static final String kTitle = "title";
  static final String kImageUrl = "imageUrl";
  static final String kIngredientList = "ingredientList";
  static final String kInstructionList = "instructionList";

  static final List<String> _keyList = [
    kId,
    kTitle,
    kImageUrl,
    kIngredientList,
    kInstructionList
  ];

  int id;
  String title;
  String imageUrl;
  List<Ingredient> ingredientList;
  List<Instruction> instructionList;

  // class creation ============================================================
  Recipe._();
  Recipe(this.title, this.imageUrl, this.ingredientList, this.instructionList);

  @override
  void initializeFromJson(Map<String, dynamic> json) {
    this.id = json[Recipe.kId] ?? null;
    this.title = json[Recipe.kTitle] ?? null;
    this.imageUrl = json[Recipe.kImageUrl] ?? null;

    this.ingredientList = json[Recipe.kIngredientList] != null
        ? json[Recipe.kIngredientList]
            .map((row) => Ingredient.createFromJson(row))
        : null;

    this.instructionList = json[Recipe.kInstructionList] != null
        ? json[Recipe.kInstructionList]
            .map((row) => Instruction.createFromJson(row))
        : null;
  }

  static Recipe createFromJson(Map<String, dynamic> json) {
    Recipe recipe = new Recipe._();
    recipe.initializeFromJson(json);

    return recipe;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {
      kId: this.id,
      kTitle: this.title,
      kImageUrl: this.imageUrl,
      kIngredientList: this.ingredientList,
      kInstructionList: this.instructionList
    };
  }

  @override
  List<String> getKeys() {
    return _keyList;
  }

  // lazy fetching of one to many relationship =================================
  Future<void> fetchIngredients() async {
    if (this.ingredientList == null)
      this.ingredientList = await Ingredient.retrieveByRecipeId(this.id);
  }

  Future<void> fetchInstructions() async {
    if (this.instructionList == null)
      this.instructionList = await Instruction.retrieveByRecipeId(this.id);
  }

  // retrieves =================================================================
  static Future<Recipe> retrieveByRowId(int rowid) async {
    Database db = await DatabaseManager.instance.database;

    String whereList = SQL_WHERE_ROWID;
    String sql = SQL_SELECT + " WHERE " + whereList;

    var result = await db.rawQuery(sql, [rowid]);

    return result != null && result.length > 0
        ? Recipe.createFromJson(result[0])
        : null;
  }

  static Future<List<Recipe>> retrieveAll() async {
    Database db = await DatabaseManager.instance.database;

    var result = await db.rawQuery(SQL_SELECT);

    return result.map((row) => Recipe.createFromJson(row));
  }

  // insert ====================================================================
  Future<int> dbInsert() async {
    Database db = await DatabaseManager.instance.database;
    this.id = await db.rawInsert(SQL_INSERT, [this.title, this.imageUrl]);
    return this.id;
  }

  // update ====================================================================
  Future<bool> dbUpdate() async {
    Database db = await DatabaseManager.instance.database;
    int count =
        await db.rawUpdate(SQL_UPDATE, [this.title, this.imageUrl, this.id]);

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

  // yall this sucks. i think all of these properties can still do their thing
  // without the need to declare functions
  set name(String newTitle) {
    title = newTitle;
  }

  set image(String newImageURL) {
    imageUrl = newImageURL;
  }

  set ingredientsAll(List<Ingredient> newList) {
    ingredientList = newList;
  }

  set instructionsAll(List<Instruction> newList) {
    instructionList = newList;
  }

  void addIngredient(Ingredient newIngredient) {
    ingredientList.add(newIngredient);
  }

  void changeIngredient(Ingredient newIngredient, int index) {
    ingredientList[index] = newIngredient;
  }

  void addIngredientAt(Ingredient newIngredient, int index) {
    ingredientList.insert(index, newIngredient);
  }

  void deleteIngredientAt(int index) {
    ingredientList.removeAt(index);
  }

  void addInstruction(Instruction newInstruction) {
    instructionList.add(newInstruction);
  }

  void addInstructionAt(Instruction newInstruction, int index) {
    instructionList.insert(index, newInstruction);
  }

  void changeInstruction(Instruction newInstruction, int index) {
    instructionList[index] = newInstruction;
  }

  void deleteInstructionAt(int index) {
    instructionList.removeAt(index);
  }
}
