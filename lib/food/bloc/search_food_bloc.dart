import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:food_delivery_app/home/bloc/home_page_bloc.dart';

class SearchPageBloc with ChangeNotifier {
  List<FoodModel> searchedFoodList = [];

  // searched text by user
  String query = "";

  List<FoodModel> searchFoodsFromList(String query) {
    final List<FoodModel> suggestionList = query.isEmpty
        ? searchedFoodList // show all foods
        : searchedFoodList.where((FoodModel food) {
            String _foodName = food.name.toLowerCase();
            String _query = query.toLowerCase();

            bool isMatch = _foodName.contains(_query);
            return (isMatch);
          }).toList();
    return suggestionList;
  }

  void loadFoodList() {
    searchedFoodList = HomePageBloc().foodList;
  }

  setQuery(String q) {
    query = q;
    notifyListeners();
  }
}
