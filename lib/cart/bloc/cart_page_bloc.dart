import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:food_delivery_app/food/model/request_model.dart';
import 'package:food_delivery_app/home/screen/home_page.dart';
import 'package:food_delivery_app/order/screen/my_order_page.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

class CartPageBloc with ChangeNotifier {
  List<FoodModel> FoodList = [];
  List<RequestModel> requestList = [];
  CartPageBloc() {
    FoodList = [
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
  }
  int totalPrice = 0;

  BuildContext? context;
  addItems(FoodModel food) {
    FoodList.add(food);
    notifyListeners();
  }

  getValue() async {
    FoodList.forEach((food) {
      int foodItemPrice = int.parse(food.price);
      totalPrice += foodItemPrice;
    });
    notifyListeners();
  }

  orderPlace(String name, String address) async {
    getValue();
    // String totalPrice = totalPrice.toString();
    if (context != null) {
      Navigator.pushReplacement(
          context!,
          MaterialPageRoute(
              builder: (BuildContext context) => const BottomNavigation()));
    }
  }

  Future<void> addOrder(String totalPrice, List<FoodModel> orderedFoodList,
      String name, String address) async {
    // getter user details

    String uidtxt = "1";
    String statustxt = "0";
    String totaltxt = totalPrice.toString();

    // creating model of list of ordered foods
    Map aux = new Map<String, dynamic>();
    orderedFoodList.forEach((food) {
      aux[food.keys] = food.toMap(food);
    });

    RequestModel request = RequestModel(
        address: address,
        name: name,
        userid: uidtxt,
        status: statustxt,
        total: totaltxt,
        foodList: aux);

    requestList.add(request);
  }
}
