// Author: @tdimhcsleumas

import 'package:swiftcook/model/data_objects/ingredient.dart';
import 'package:swiftcook/model/data_objects/instruction.dart';
import 'package:swiftcook/model/data_objects/serializable.dart';

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
