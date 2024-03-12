import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_app/auth/screens/signup_page.dart';
import 'package:food_delivery_app/food/bloc/food_detail_page_bloc.dart';
import 'package:food_delivery_app/resources/auth_methods.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:food_delivery_app/auth/screens/login_page.dart';
import 'package:food_delivery_app/home/screen/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          UniversalVariables.blueColor.value,
          const <int, Color>{
            50: UniversalVariables.blueColor,
            100: UniversalVariables.blueColor,
            200: UniversalVariables.blueColor,
            300: UniversalVariables.blueColor,
            400: UniversalVariables.blueColor,
            500: UniversalVariables.blueColor,
            600: UniversalVariables.blueColor,
            700: UniversalVariables.blueColor,
            800: UniversalVariables.blueColor,
            900: UniversalVariables.blueColor,
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      // home: StreamBuilder<User?>(
      //     stream: _authMethods.onAuthStateChanged,
      //     builder: (context, AsyncSnapshot<User?> snapshot) {
      //       if (snapshot.hasData && snapshot.data != null) {
      //         return HomePage();
      //       } else {
      //         return LoginPage();
      //       }
      //     }));
    );
  }
}
