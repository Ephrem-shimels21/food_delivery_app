import 'package:flutter/material.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:food_delivery_app/food/model/request_model.dart';
import 'package:food_delivery_app/food/widget/food_title_widget.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

class OrderWidget extends StatefulWidget {
  final RequestModel request;
  OrderWidget(this.request);

  @override
  // ignore: library_private_types_in_public_api
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  List<Step> steps = [
    const Step(
      content: Text('asd'),
      title: Text('Placed'),
      isActive: true,
    ),
    const Step(
      title: Text('On The Way'),
      content: Text('asd'),
      isActive: true,
    ),
    const Step(
      content: Text('Completed'),
      title: Text('Completed'),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.request.name,
              style: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.request.address,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.pngitem.com/pimgs/m/252-2523515_delivery-clipart-delivery-order-frames-illustrations.png"),
            ),
            trailing: Text(
              widget.request.total + " Birr",
              style: const TextStyle(
                color: UniversalVariables.darkBlueColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          createSatusBar(),
          Container(
            padding: const EdgeInsets.only(left: 20.0, top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Food",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                createListOfFood(),
              ],
            ),
          )
        ],
      ),
    );
  }

  createSatusBar() {
    return Container(
      height: 100.0,
      child: Stepper(
        currentStep: int.parse(widget.request.status),
        steps: steps,
        type: StepperType.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controlsBuilder:
            (BuildContext context, ControlsDetails controlsDetails) =>
                Container(
          height: 0.0,
        ),
      ),
    );
  }

  createListOfFood() {
    List<FoodModel> foodList = [];
    widget.request.foodList.forEach((key, value) {
      FoodModel food = FoodModel(
        name: value["name"],
        image: value["image"],
        keys: value["keys"],
        price: value["price"],
        description: value["description"],
        menuId: value["menuId"],
        discount: value["discount"],
      );
      foodList.add(food);
    });

    return Container(
      height: 200.0,
      child: foodList.length == -1
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodList.length,
              itemBuilder: (_, index) {
                return FoodTitleWidget(
                  foodList[index],
                );
              }),
    );
  }
}
