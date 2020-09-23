// Author: @tdimhcsleumas

import 'package:swiftcook/model/ingredient.dart';
import 'package:swiftcook/model/instruction.dart';
import 'package:swiftcook/model/serializable.dart';

class Recipe extends Serializable {
  static final String kTitle = "title";
  static final String kImageUrl = "imageUrl";
  static final String kIngredientList = "ingredientList";
  static final String kInstructionList = "instructionList";

  static final List<String> _keyList = [
    kTitle,
    kImageUrl,
    kIngredientList,
    kInstructionList
  ];

  String title;
  String imageUrl;
  List<Ingredient> ingredientList;
  List<Instruction> instructionList;

  Recipe(this.title, this.imageUrl, this.ingredientList, this.instructionList);

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {
      kTitle: this.title,
      kImageUrl: this.imageUrl,
      kIngredientList: this.ingredientList,
      kInstructionList: this.instructionList
    };
  }

  static List<Recipe> getTestData() {
    return [
      Recipe("Carbonara", "assets/carbonara.jpg", [
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
      Recipe("Chicken Marsala", "assets/chicken_marsala.jpg",
          [Ingredient("lkj", 1.0, "ml")], [Instruction("adsfasdf")]),
      Recipe(
          "Pepperoni Pizza",
          "assets/pizza.png",
          [Ingredient("fffffffffffff", 1.0, "ml")],
          [Instruction("ffffffffffffff")]),
    ];
  }
}
