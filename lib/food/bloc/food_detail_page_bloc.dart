import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:food_delivery_app/resources/auth_methods.dart';
// import 'package:food_delivery_app/resources/firebase_helper.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
// import 'package:food_delivery_app/resources/database_sql.dart';
import 'package:food_delivery_app/home/bloc/home_page_bloc.dart';
import 'package:food_delivery_app/cart/bloc/cart_page_bloc.dart';
import 'package:provider/provider.dart';

class FoodDetailPageBloc with ChangeNotifier {
  // AuthMethods mauthMethod = AuthMethods();
  // FirebaseHelper mFirebaseHelper = FirebaseHelper();
  CartPageBloc cartPageBloc = CartPageBloc();
  HomePageBloc homePageBloc = HomePageBloc();

  List<FoodModel> foodList = [];
  var random = Random();
  String rating = "1.00";

  int mItemCount = 1;

  BuildContext? context;

  addToCart(FoodModel food) async {
    // DatabaseSql databaseSql = DatabaseSql();

    // await databaseSql.openDatabaseSql();
    // await databaseSql.insertData(food);
    // await databaseSql.getData();
    cartPageBloc.FoodList.add(food);

    final snackBar = SnackBar(
      content: const Text('Food Added To Cart'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );

    mItemCount = 1;
    if (context != null) {
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
    notifyListeners();
  }

  getPopularFoodList() {
    List<FoodModel> popularList = homePageBloc.popularFoodList;
    List<FoodModel> list =
        popularList.where((food) => food.keys == "01").toList();
    foodList = list;
    notifyListeners();
    // p.fetchSpecifiedFood("06").then((List<FoodModel> list) {
    //   foodList = list;
    //   notifyListeners();
    // });
  }

  void increamentItems() {
    mItemCount++;
    notifyListeners();
  }

  void decreamentItems() {
    if (mItemCount > 1) {
      mItemCount--;
    }
    notifyListeners();
  }

  void generateRandomRating() {
    rating = doubleInRange(random, 3.5, 5.0).toStringAsFixed(1);
  }

  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}
