import 'dart:async';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSql {
  late Database database;
  int? count;

  Future<void> openDatabaseSql() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE cartTable(keys TEXT PRIMARY KEY, name TEXT, price TEXT, menuId TEXT, image TEXT, dicount TEXT, description TEXT)",
        );
      },
    );
  }

  Future<bool> insertData(FoodModel food) async {
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO cartTable(keys, name, price, menuId, image, discount, description) VAlUES("${food.keys}", "${food.name}","${food.price}", "${food.menuId}", "${food.image}","${food.discount}", "${food.description}")');
    });
    return true;
  }

  Future<int?> countData() async {
    count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM cartTable'));
    assert(count == 2);
    return count;
  }

  Future<bool> deleteData(String id) async {
    count =
        await database.rawDelete('DELETE FROM cartTable WHERE keys = ?', [id]);

    return true;
  }

  Future<bool> deleteAllData() async {
    count = await database.rawDelete('DELETE FROM cartTable');
    return true;
  }

  Future<List<FoodModel>> getData() async {
    List<FoodModel> foodList = [];
    List<Map> list = await database.rawQuery('SELECT * FROM cartTable');

    list.forEach((map) {
      foodList.add(FoodModel.fromMap(map as Map<String, dynamic>));
    });
    return foodList;
  }
}
