import 'dart:async';

import '../data_objects/recipe.dart';

enum RecipeViewState { Busy, DataRetrieved, NoData, DataModified}

class RecipeController {
  final StreamController<RecipeViewState> _stateController = StreamController<RecipeViewState>();

  List<Recipe> _recipes;

  List<Recipe> get recipes {
    return _recipes;
  }

  Stream<RecipeViewState> get recipeState {
    return _stateController.stream;
  }

  // fetch recipe list
  void fetchAllRecipes() {
    _stateController.add(RecipeViewState.Busy);
    Recipe.retrieveAll().then((List<Recipe> recipeList) {
      _recipes = recipeList;

      if (_recipes.length != 0) {
        _stateController.add(RecipeViewState.DataRetrieved);
      } else {
        _stateController.add(RecipeViewState.NoData);
      }

    }).catchError((error) {
      _stateController.addError(error);
    }); 
  }

  // create new recipe
  void createNewRecipe(Recipe recipe) {
    _stateController.add(RecipeViewState.Busy);

    recipe.dbInsert().then((result) {

      _stateController.add(RecipeViewState.DataModified);
    }).catchError((error) {

      _stateController.addError(error);
    }); 
  }  

  // update by index
  void updateRecipe(Recipe recipe) {
    if (recipe == null) throw Exception("updateRecipe called on null recipe");

    _stateController.add(RecipeViewState.Busy);

    recipe.dbUpdate().then((bool result) {
      _stateController.add(RecipeViewState.DataModified);
    }).catchError((error) {
      _stateController.addError(error);
    });
  }

  // delete by id
  void deleteByIdx(int idx) {

    _stateController.add(RecipeViewState.Busy);

    _recipes[idx].dbDelete().then((bool result) {
      _stateController.add(RecipeViewState.DataModified);
    }).catchError((error) {
      _stateController.addError(error);
    });
  }
}