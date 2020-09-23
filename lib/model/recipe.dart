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
      Recipe("clean and family friendly", "img.png", [
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
