import 'package:flutter/material.dart';
import 'package:food_delivery_app/cart/screen/cart_page.dart';
import 'package:food_delivery_app/food/model/food_model.dart';

class CartItems extends StatefulWidget {
  final FoodModel fooddata;
  CartItems(this.fooddata);

  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          child: ListTile(
            leading: Container(
              height: 80.0,
              width: 80.0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    widget.fooddata.image,
                    fit: BoxFit.cover,
                  )),
            ),
            title: Text(
              widget.fooddata.name,
              style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: Text(
              "${widget.fooddata.price} birr",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                size: 20.0,
              ),
              onPressed: () => deleteFoodFromCart(widget.fooddata.keys),
            ),
          )),
    );
  }

  deleteFoodFromCart(String keys) async {
    bool isDeleted = true;
    if (isDeleted) {
      final snackBar = SnackBar(
        content: const Text('Removed Food Item'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // todo code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => CartPage()));
    }
  }
}
