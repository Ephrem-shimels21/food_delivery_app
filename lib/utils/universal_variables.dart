import 'package:flutter/material.dart';
import 'package:food_delivery_app/auth/screens/login_page.dart';
import 'package:food_delivery_app/cart/screen/cart_page.dart';
import 'package:food_delivery_app/home/screen/home_page.dart';
import 'package:food_delivery_app/order/screen/my_order_page.dart';

class UniversalVariables {
  int _current = 0;
  static const Color blueColor = Color(0xff0077d7);
  static const Color lightBlueColor = Color(0xff00b6f3);
  static const Color darkBlueColor = Color(0xff0184dc);
  static const Color paleBlueColor = Color(0xffb3e5fc);
  static const Color navyBlueColor = Color(0xff001f3f);
  static const Color carolinaBlueColor = Color(0xff7ba9d1);
  static const Color columbiaBlueColor = Color(0xffc2e3f6);
  static const Color aliceBlueColor = Color(0xfff0f8ff);
  static const Color marineBlueColor = Color(0xff4f86c6);

  static const Color greyColor = Color(0xff8f8f8f);
  static const Color userCircleBackground = Color(0xff2b2b33);
  static const Color onlineDotColor = Color(0xff46dc64);
  static const Color separatorColor = Color(0xff272c35);

  static const Color senderColor = Color(0xff2b343b);
  static const Color receiverColor = Color(0xff1e2225);

  static const Gradient fabGradient = LinearGradient(
    colors: [lightBlueColor, darkBlueColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _current = 0;
  final List<Widget> _pages = [
    HomePage(),
    CartPage(),
    MyOrderPage(),
    LoginPage(),
  ];

  void onTapped(int index) {
    setState(() {
      _current = index;
    });
    if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_current],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _current,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        selectedItemColor: UniversalVariables.darkBlueColor,
        unselectedItemColor: Colors.blue[200],
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }
}
