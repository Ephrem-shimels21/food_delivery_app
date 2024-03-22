import 'package:flutter/material.dart';
import 'package:food_delivery_app/cart/bloc/cart_page_bloc.dart';
import 'package:food_delivery_app/cart/widget/cart_item_widget.dart';
import 'package:food_delivery_app/food/bloc/food_detail_page_bloc.dart';
import 'package:food_delivery_app/home/bloc/home_page_bloc.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => FoodDetailPageBloc()),
      ChangeNotifierProvider(create: (_) => CartPageBloc())
    ], child: CartPageContent());
  }
}

class CartPageContent extends StatefulWidget {
  const CartPageContent() : super();

  @override
  _CartPageContentState createState() => _CartPageContentState();
}

class _CartPageContentState extends State<CartPageContent> {
  late CartPageBloc cartPageBloc;
  late FoodDetailPageBloc foodDetailPageBloc;
  TextEditingController nametextcontroller = TextEditingController();
  TextEditingController addresstextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await cartPageBloc.getDatabaseValue();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO:  Do We need to keep this here or in didChangeDependencies
    cartPageBloc = Provider.of<CartPageBloc>(context);
    foodDetailPageBloc = Provider.of<FoodDetailPageBloc>(context);
    cartPageBloc.context = context;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Order",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.0),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 25.0),
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              createListCart(),
              createTotalPriceWidget(),
            ],
          ),
        ),
      ),
    );
  }

  createTotalPriceWidget() {
    return Container(
      color: Colors.white30,
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total :",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 15.0),
              ),
              Text(
                "${cartPageBloc.totalPrice} birr",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 13.0),
              ),
            ],
          ),
          const Divider(
            thickness: 2.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.14,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      UniversalVariables.darkBlueColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
                onPressed: () => _showDialog(),
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  createListCart() {
    var cart = Provider.of<CartPageBloc>(context, listen: true);
    // print(cartPageBloc.FoodList);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      // height: 400,
      child: cart.FoodList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: cart.FoodList.length,
              itemBuilder: (_, index) {
                return CartItems(
                  cart.FoodList[index],
                );
              }),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return handleOrderPlacement();
      },
    );
  }

  handleOrderPlacement() {
    //check if card is empty
    cartPageBloc.getValue();
    if (cartPageBloc.totalPrice == 0) {
      print("not order");
      return AlertDialog(
        title: const Text('You can add what you want'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Card Is Empty !'),
              Text('Add Some Product on Card First'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('We will deliver to you soon'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Fill Details'),
              TextField(
                controller: nametextcontroller,
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Name', hintText: 'eg. Ephrem'),
              ),
              TextField(
                controller: addresstextcontroller,
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'eg. 5 kilo, Arada subcity'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Order'),
            onPressed: () {
              cartPageBloc.orderPlace(
                  nametextcontroller.text, addresstextcontroller.text);
            },
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    nametextcontroller.dispose();
    addresstextcontroller.dispose();
  }
}
