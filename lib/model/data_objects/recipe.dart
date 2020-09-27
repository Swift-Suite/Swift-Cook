// Author: @tdimhcsleumas

import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';
import 'package:swiftcook/model/data_objects/serializable.dart';

class Recipe extends Serializable {
  static const String SQL_INSERT = '''
  INSERT INTO Recipe (Title, ImageUrl) 
  Values (?, ?);
  ''';
  static const String SQL_SELECT = '''
  SELECT
    rowid, Title, ImageUrl
  FROM 
    Recipe
  ''';

  static const String SQL_UPDATE = '''
  UPDATE Recipe
  SET Title = ?,
      ImageUrl = ?
  ''';

  static const String SQL_DELETE = '''
  DELETE FROM Recipe WHERE Id = ?
  ''';

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

  Recipe(this.title, this.imageUrl, this.ingredientList, this.instructionList);

  // CRUD stuff

  static Future<List<Recipe>> retrieveAll() async {
    return [];
  }

  static Future<Recipe> retrieveByRecipeId(int id) async {}

  // returns the int of the inserted record on success, throws exception on error
  Future<int> dbInsert() async {
    return 1;
  }

  // returns true on success, false on failure
  Future<bool> dbUpdate() async {
    return true;
  }

  // returns true on success, false on failure
  Future<bool> dbDelete() async {
    return true;
  }

  List<String> getKeys() {
    return _keyList;
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

  static List<Recipe> getTestData() {
    return [
      Recipe("clean and family friendly", "img.png", [
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
        Ingredient("code", 1.0, "ml"),
      ], [
        Instruction("talsdfj")
      ]),
      Recipe("lkjlkjlkjlkjljk", "img.png", [Ingredient("lkj", 1.0, "ml")],
          [Instruction("adsfasdf")]),
      Recipe(
          "lol xddddddddddddddddd",
          "img.png",
          [Ingredient("fffffffffffff", 1.0, "ml")],
          [Instruction("ffffffffffffff")]),
    ];
  }
}
