// Author: @tdimhcsleumas

class Ingredient {
  static final String kTitle = "title";
  static final String kQuantity = "quantity";
  static final String kUnit = "unit";

  static final List<String> keyList = [kTitle, kQuantity, kUnit];

  String title;
  double quantity;
  String unit;

  Ingredient(this.title, this.quantity, this.unit);
}
