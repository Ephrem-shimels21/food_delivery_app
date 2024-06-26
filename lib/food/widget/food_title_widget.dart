import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:food_delivery_app/food/screens/food_detail_page.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

class FoodTitleWidget extends StatelessWidget {
  final FoodModel fooddata;
  FoodTitleWidget(this.fooddata);
  @override
  Widget build(BuildContext context) {
    var random = Random();
    gotoFoodDetails() {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetailPage(fooddata)));
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => FoodDetailPage(food: fooddata)));
    }

    return GestureDetector(
      onTap: () => gotoFoodDetails(),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Hero(
                      tag: "avatar_${fooddata.keys.toString()}",
                      child: Image.network(
                        fooddata.image,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Wrap(
                spacing: 20.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                direction: Axis.vertical,
                children: [
                  Text(
                    "${fooddata.name}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Icon(
                        Icons.star,
                        color: UniversalVariables.darkBlueColor,
                      ),
                      Text(
                        doubleInRange(random, 3.5, 5.0).toStringAsFixed(1),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UniversalVariables.darkBlueColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        "Cafe Western Food",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                  Text(
                    "${fooddata.price} birr",
                    style: const TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ],
              )
            ],
          )),
    );
  }

  //we are generating random rating for now
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}
