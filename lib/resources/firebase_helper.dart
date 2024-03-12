import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_delivery_app/category/category_model.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:food_delivery_app/food/model/request_model.dart';
import 'package:food_delivery_app/resources/auth_methods.dart';
import 'package:food_delivery_app/resources/database_sql.dart';

class FirebaseHelper {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;
  static final DatabaseReference _ordersReference =
      _database.ref().child('orders');
  static final DatabaseReference _catagoryReference =
      _database.ref().child('category');
  static final DatabaseReference _foodReference = _database.ref().child('food');

  Future<List<FoodModel>> fetchAllFood() async {
    List<FoodModel> foodList = <FoodModel>[];
    DatabaseReference foodReference = _database.ref().child('Foods');
    DatabaseEvent event = await foodReference.once();
    event.snapshot.children.forEach((DataSnapshot element) {
      if (element.value is Map) {
        FoodModel food =
            FoodModel.fromMap(element.value as Map<String, dynamic>);
        foodList.add(food);
      }
    });
    return foodList;
  }

  Future<List<FoodModel>> fetchSpecifiedFoods(String queryStr) async {
    List<FoodModel> foodList = <FoodModel>[];

    DatabaseReference foodReference = _database.ref().child("Foods");
    DatabaseEvent event = await foodReference.once();
    event.snapshot.children.forEach((DataSnapshot element) {
      if (element.value is Map) {
        FoodModel food =
            FoodModel.fromMap(element.value as Map<String, dynamic>);
        if (food.menuId == queryStr) {
          foodList.add(food);
        }
      }
    });
    return foodList;
  }

  Future<bool> palceOrder(RequestModel request) async {
    await _ordersReference
        .child(request.userid)
        .push()
        .set(request.toMap(request));
    return true;
  }

  Future<List<CategoryModel>> fetchCategory() async {
    List<CategoryModel> categoryList = [];
    DatabaseEvent event = await _catagoryReference.once();
    event.snapshot.children.forEach((DataSnapshot element) {
      if (element.value is Map) {
        Map e = element.value as Map<dynamic, dynamic>;
        CategoryModel category =
            CategoryModel(image: e['Image'], name: e['name'], keys: e['keys']);
        categoryList.add(category);
      }
    });
    return categoryList;
  }

  Future<List<RequestModel>> fetchOrders(User currentUser) async {
    List<RequestModel> requestList = [];
    DatabaseReference foodReference = _ordersReference.child(currentUser.uid);

    DatabaseEvent event = await foodReference.once();
    event.snapshot.children.forEach((DataSnapshot element) {
      if (element.value is Map) {
        Map e = element.value as Map<dynamic, dynamic>;
        RequestModel request = RequestModel(
            address: e['address'],
            name: e['name'],
            userid: e['uid'],
            status: e['status'],
            total: e['total'],
            foodList: e['foodList']);
        requestList.add(request);
      }
    });
    return requestList;
  }

  Future<void> addOrder(String totalPrice, List<FoodModel> orderedFoodList,
      String name, String address) async {
    User? user = await AuthMethods().getCurrentUser();
    if (user == null) {
      return;
    }
    String uidtxt = user.uid;
    String statustxt = "0";
    String totaltxt = totalPrice.toString();

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

    await _ordersReference
        .child(request.userid)
        .push()
        .set(request.toMap(request))
        .then((vaue) async {
      DatabaseSql databaseSql = DatabaseSql();
      await databaseSql.openDatabaseSql();
      await databaseSql.deleteAllData();
    });
  }
}
