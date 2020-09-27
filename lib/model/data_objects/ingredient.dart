// Author: @tdimhcsleumas
import './serializable.dart';

class Ingredient extends Serializable {
  // define const string
  static const String SQL_INSERT = '''
  INSERT INTO Ingredient (RecipeId, Title, Quantity, Unit)
  VALUES (?,?,?,?);
  ''';

  static const String SQL_SELECT = '''
  SELECT
    RecipeId, Title, Quantity, Unit
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

  static final String kId = "id";
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

  String title;
  double quantity;
  String unit;

  Ingredient(this.title, this.quantity, this.unit);

  // TODO: this later
  static Future<List<Ingredient>> retrieveByRecipeId(int recipeId) async {
    return [];
  }

  Future<int> dbInsert() {
    return 1;
  }

  Future<bool> dbUpdate() {
    return Future<true>;
  }

  Future<bool> dbDelete() {
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
