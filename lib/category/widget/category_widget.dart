import 'package:flutter/material.dart';
import 'package:food_delivery_app/category/category_model.dart';
import 'package:food_delivery_app/category/category_list_page.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    gotoCategoryList() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CategoryListPage(category)));
    }

    return GestureDetector(
        onTap: () => gotoCategoryList(),
        child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 100.0,
                width: 150.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    category.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                category.name,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Row(children: [
                SizedBox(
                  height: 10.0,
                ),
                Icon(
                  Icons.star,
                  color: UniversalVariables.darkBlueColor,
                ),
                Text(
                  "4.0,",
                  style: TextStyle(
                      color: UniversalVariables.darkBlueColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "cafe Western Food",
                  style: TextStyle(color: Colors.black),
                )
              ])
            ])));
  }
}
