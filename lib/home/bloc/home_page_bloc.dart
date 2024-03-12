// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/category/category_model.dart';
import 'package:food_delivery_app/food/model/food_model.dart';

class HomePageBloc with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<FoodModel> foodList = [];
  List<FoodModel> popularFoodList = [];
  List<FoodModel> bannerFoodList = [];

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  CategoryModel recentlyCategory = CategoryModel(
      image:
          "https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
      name: 'burger',
      keys: '08');
  CategoryModel recentlyCategory2 = CategoryModel(
      image:
          "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg",
      name: "Pizza",
      keys: "04");
  CategoryModel recentlyCategory3 = CategoryModel(
      image:
          "https://static.toiimg.com/thumb/54659021.cms?width=1200&height=1200",
      name: "french fries",
      keys: "07");
  CategoryModel recentlyCategory4 = CategoryModel(
      image:
          "https://i.pinimg.com/originals/3b/b4/ea/3bb4ea708b73c60a11ccd4a7bdbb1524.jpg",
      name: "kfc chicken",
      keys: "09");

  HomePageBloc() {
    categoryList = [
      recentlyCategory,
      recentlyCategory2,
      recentlyCategory3,
      recentlyCategory4
    ];
    foodList = [
      FoodModel(
          keys: "01",
          discount: "10%",
          description: "this is the food",
          name: "Burger",
          image:
              "https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
          price: "10",
          menuId: "08"),
      FoodModel(
          keys: "02",
          discount: "10%",
          description: "this is the food",
          name: "Pizza",
          image:
              "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg",
          price: "20",
          menuId: "04"),
      FoodModel(
          keys: "03",
          discount: "10%",
          description: "this is the food",
          name: "French Fries",
          image:
              "https://static.toiimg.com/thumb/54659021.cms?width=1200&height=1200",
          price: "5",
          menuId: "07"),
      FoodModel(
          keys: "04",
          discount: "10%",
          description: "this is the food",
          name: "KFC Chicken",
          image:
              "https://i.pinimg.com/originals/3b/b4/ea/3bb4ea708b73c60a11ccd4a7bdbb1524.jpg",
          price: "15",
          menuId: "09"),
    ];
    popularFoodList = [
      FoodModel(
          keys: "01",
          discount: "10%",
          description: "this is the food",
          name: "Burger",
          image:
              "https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
          price: "10",
          menuId: "08"),
      FoodModel(
          keys: "02",
          discount: "10%",
          description: "this is the food",
          name: "Pizza",
          image:
              "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg",
          price: "20",
          menuId: "04"),
      FoodModel(
          keys: "03",
          discount: "10%",
          description: "this is the food",
          name: "French Fries",
          image:
              "https://static.toiimg.com/thumb/54659021.cms?width=1200&height=1200",
          price: "5",
          menuId: "07"),
      FoodModel(
          keys: "04",
          discount: "10%",
          description: "this is the food",
          name: "KFC Chicken",
          image:
              "https://i.pinimg.com/originals/3b/b4/ea/3bb4ea708b73c60a11ccd4a7bdbb1524.jpg",
          price: "15",
          menuId: "09"),
    ];
    bannerFoodList = [
      FoodModel(
          keys: "03",
          discount: "10%",
          description: "this is the food",
          name: "French Fries",
          image:
              "https://static.toiimg.com/thumb/54659021.cms?width=1200&height=1200",
          price: "5",
          menuId: "07"),
      FoodModel(
          keys: "02",
          discount: "10%",
          description: "this is the food",
          name: "Pizza",
          image:
              "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg",
          price: "20",
          menuId: "04"),
    ];
  }

  // late User? mFirebaseUser;

  // getCurrentUser() {
  //   mAuthMethods.getCurrentUser().then((User? currentUser) {
  //     mFirebaseUser = currentUser;
  //     notifyListeners();
  //   }).catchError((error) {
  //     if (error is FirebaseException) {
  //       print("ephi ${error.message}");
  //       return null;
  //     } else {
  //       throw error;
  //     }
  //   });
  // }

  // getCategoryFoodList() {
  //   categoryList.clear();
  //   mFirebaseHelper.fetchCategory().then((List<CategoryModel> cList) {
  //     categoryList = cList;
  //     notifyListeners();
  //   }).catchError((error) {
  //     if (error is FirebaseException) {
  //       print("ephi ${error.message}");
  //       return null;
  //     } else {
  //       throw error;
  //     }
  //   });
  // }

  // getRecommendedFoodList() {
  //   mFirebaseHelper.fetchAllFood().then((List<FoodModel> flist) {
  //     popularFoodList.forEach((FoodModel food) {
  //       if (food.menuId == "05") {
  //         popularFoodList.add(food);
  //       } else if (food.menuId == "03") {
  //         foodList.add(food);
  //       } else if (food.menuId == "07") {
  //         bannerFoodList.add(food);
  //       }
  //       notifyListeners();
  //     });
  //   }).catchError((error) {
  //     if (error is FirebaseException) {
  //       print("ephi ${error.message}");
  //       return null;
  //     } else {
  //       throw error;
  //     }
  //   });
  // }
}
