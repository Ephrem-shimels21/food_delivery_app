import 'package:flutter/material.dart';
import 'package:food_delivery_app/category/category_model.dart';
import 'package:food_delivery_app/home/screen/home_page.dart';
// import 'package:food_delivery_app/resources/firebase_helper.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:food_delivery_app/food/widget/food_title_widget.dart';

class CategoryListPage extends StatefulWidget {
  final CategoryModel category;
  CategoryListPage(this.category);

  @override
  _categoryListPageState createState() => _categoryListPageState();
}

class _categoryListPageState extends State<CategoryListPage> {
  // FirebaseHelper mFirebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(80.0)),
                image: DecorationImage(
                    image: NetworkImage(widget.category.image),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 60.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(80.0)),
                      gradient: LinearGradient(
                        colors: [Colors.black45, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.category.name,
                      style: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "12 restaurants ",
                        style: TextStyle(color: Colors.black45),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: UniversalVariables.blueColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  createFoodList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  createFoodList() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<FoodModel>>(
            stream: Stream.fromIterable([
              [
                FoodModel(
                  keys: widget.category.keys,
                  description: '',
                  discount: '0',
                  image: '',
                  menuId: '',
                  name: '',
                  price: '0',
                )
              ]
            ]),
            builder: (context, AsyncSnapshot<List<FoodModel>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null || snapshot.data!.length == 0) {
                  return const Center(
                    child: Text("No Food Available"),
                  );
                }
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return FoodTitleWidget(
                        snapshot.data![index],
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
