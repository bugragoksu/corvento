import 'package:eventapp/src/services/repository/category_repository.dart';
import 'package:eventapp/src/model/category.dart';
import 'package:flutter/material.dart';

enum CategoryState {
  InitialCategoryState,
  CategoryLoadingState,
  CategoryLoadedState,
  CategoryErrorState
}

class CategoryViewModel with ChangeNotifier {
  CategoryState _state;
  CategoryRepository _repository = CategoryRepository();
  List<Category> categoryList;

  CategoryViewModel() {
    categoryList = List<Category>();
    _state = CategoryState.InitialCategoryState;
    getAllCategories();
  }

  CategoryState get state => _state;

  set state(CategoryState value) {
    _state = value;
    notifyListeners();
  }

  Future<List<Category>> getAllCategories() async {
    try {
      state = CategoryState.CategoryLoadingState;
      categoryList.clear();
      categoryList = await _repository.getCategories();
      state = CategoryState.CategoryLoadedState;
    } catch (e) {
      state = CategoryState.CategoryErrorState;
    }
    return categoryList;
  }
}
