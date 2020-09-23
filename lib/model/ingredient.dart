// Author: @tdimhcsleumas
import './serializable.dart';

class Ingredient extends Serializable {
  static final String kTitle = "title";
  static final String kQuantity = "quantity";
  static final String kUnit = "unit";

  static final List<String> _keyList = [kTitle, kQuantity, kUnit];

  String title;
  double quantity;
  String unit;

  Ingredient(this.title, this.quantity, this.unit);

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {kTitle: this.title, kQuantity: this.quantity, kUnit: this.unit};
  }
}
