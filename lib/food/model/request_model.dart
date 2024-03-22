import 'package:food_delivery_app/food/model/food_model.dart';

class RequestModel {
  final String address;
  final Map foodList;
  final String name;
  final String userid;
  final String status;
  final String total;

  RequestModel({
    required this.address,
    required this.foodList,
    required this.name,
    required this.userid,
    required this.status,
    required this.total,
  });

  Map toMap(RequestModel request) {
    var data = Map<String, dynamic>();
    data['address'] = request.address;
    data['foodList'] = request.foodList;
    data['name'] = request.name;
    data['userid'] = request.userid;
    data['status'] = request.status;
    data['total'] = request.total;
    return data;
  }

  factory RequestModel.fromMap(Map<dynamic, dynamic> mapData) {
    return RequestModel(
      address: mapData['address'],
      foodList: mapData['foodList'],
      name: mapData['name'],
      userid: mapData['uid'],
      status: mapData['status'],
      total: mapData['total'],
    );
  }
}

List<FoodModel> foodL = [
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
Map<dynamic, dynamic> dic() {
  Map aux = new Map<String, dynamic>();

  foodL.forEach((food) {
    aux[food.keys] = food.toMap(food);
  });
  return aux;
}

List<RequestModel> requestArr = [
  RequestModel(
      foodList: dic(),
      address: "01",
      status: "0", // Set status to "0" for the first step
      name: "Burger",
      total: "10",
      userid: "08"),
  RequestModel(
      foodList: dic(),
      address: "02",
      status: "1", // Set status to "1" for the second step
      name: "Pizza",
      total: "20",
      userid: "04"),
  RequestModel(
      foodList: dic(),
      address: "03",
      status: "2", // Set status to "2" for the third step
      name: "French Fries",
      total: "5",
      userid: "07"),
  RequestModel(
      foodList: dic(),
      address: "04",
      status: "2", // Set status to "3" for the fourth step
      name: "KFC Chicken",
      total: "15",
      userid: "09"),
];
