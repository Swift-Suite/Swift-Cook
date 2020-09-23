// Author: @tdimhcsleumas

import 'package:swiftcook/model/ingredient.dart';
import 'package:swiftcook/model/instruction.dart';

class Recipe {
  static final String kTitle = "title";
  static final String kImageUrl = "imageUrl";
  static final String kIngredientList = "ingredientList";
  static final String kInstructionList = "instructionList";

  String title;
  String imageUrl;
  List<Ingredient> ingredientList;
  List<Instruction> instructionList;

  Recipe(this.title, this.imageUrl, this.ingredientList, this.instructionList);

  static List<Recipe> getTestData() {
    return [
      Recipe("Cock and ball torture", "img.png", [
        Ingredient("Semen", 1.0, "ml"),
        Ingredient("Semen", 1.0, "ml"),
        Ingredient("Semen", 1.0, "ml"),
      ], [
        Instruction("Eat ass and skate fast")
      ]),
      Recipe(
          "big balls lkjlkjlkjlkjljk",
          "img.png",
          [Ingredient("Semen", 1.0, "ml")],
          [Instruction("Eat ass and skate fast")]),
      Recipe(
          "lol xddddddddddddddddd",
          "img.png",
          [Ingredient("Semen", 1.0, "ml")],
          [Instruction("Eat ass and skate fast")]),
    ];
  }
}
