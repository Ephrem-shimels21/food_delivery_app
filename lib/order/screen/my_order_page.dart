import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_delivery_app/food/model/request_model.dart';
import 'package:food_delivery_app/order/widget/order_widget.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  List<RequestModel> requestList = [];

  late User currentUser;

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
    //   currentUser = await authMethods.getCurrentUser();
    //   mFirebaseHelper.fetchOrders(currentUser).then((List<RequestModel> list) {
    //     // there are not much sync operation in myorder page, i.e didn;t made any bloc file :)
    //     setState(() {
    //       requestList = list;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, left: 18.0),
              child: Text(
                "My Orders",
                style: TextStyle(
                  color: UniversalVariables.darkBlueColor,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 20.0),
              child: createListOfOrder(),
            ),
          ],
        ),
      ),
    );
  }

  createListOfOrder() {
    return requestList.length == -1
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: requestList.length,
            itemBuilder: (_, index) {
              return OrderWidget(
                requestList[index],
              );
            },
          );
  }
}
