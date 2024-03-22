import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_delivery_app/auth/screens/login_page.dart';
import 'package:food_delivery_app/cart/bloc/cart_page_bloc.dart';
import 'package:food_delivery_app/cart/screen/cart_page.dart';
import 'package:food_delivery_app/category/category_model.dart';
import 'package:food_delivery_app/food/bloc/food_detail_page_bloc.dart';
import 'package:food_delivery_app/food/screens/food_detail_page.dart';
import 'package:food_delivery_app/food/screens/food_search_page.dart';
import 'package:food_delivery_app/food/widget/food_title_widget.dart';
import 'package:food_delivery_app/home/bloc/home_page_bloc.dart';
import 'package:food_delivery_app/order/screen/my_order_page.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/category/widget/category_widget.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomePageBloc()),
      ChangeNotifierProvider(create: (_) => FoodDetailPageBloc())
    ], child: HomePageContent());
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late HomePageBloc homePageBloc;
  late FoodDetailPageBloc foodDetailPageBloc;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // homePageBloc.getCurrentUser();
      // homePageBloc.getCategoryFoodList();
      // homePageBloc.getRecommendedFoodList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: // do we need to keep this here or in didChangeDependencies
    homePageBloc = Provider.of<HomePageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: UniversalVariables.darkBlueColor),
        elevation: 0.0,
        title: const Text(
          "Home",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createSearchBar(),
                const SizedBox(
                  height: 10.0,
                ),
                createbanner(),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                  child: Text(
                    "Recently Added",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                createListRecentlyAdd(),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    "Food Category",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 5)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return createFoodCategory();
                  },
                ),
                // createFoodCategory(),
                createPopularFoodList(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    "For You",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                createForYou(),
              ],
            )),
      ),
    );
  }

  createbanner() {
    // for creating image list with name
    final List<Widget> imageSliders = homePageBloc.bannerFoodList
        .map((item) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodDetailPage(food: item))),
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item.image,
                          fit: BoxFit.cover,
                          width: 800.0,
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${item.name}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
          child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: imageSliders,
          ),
        ],
      )),
    );
  }

  createBottomNavigation() {
    List _pages = [
      HomePage(),
      CartPage(),
      MyOrderPage(),
      LoginPage(),
    ];
    onTapped(int index) {
      _current = index;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => _pages[_current]));
    }

    return BottomNavigationBar(
      onTap: (index) => onTapped(index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'My Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.clear),
          label: 'Logout',
        ),
      ],
      selectedItemColor: UniversalVariables.darkBlueColor,
      unselectedItemColor: UniversalVariables.greyColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    );
  }

  // createDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: const EdgeInsets.all(0.0),
  //       children: <Widget>[
  //         const DrawerHeader(
  //           decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: UniversalVariables.senderColor,
  //           ),
  //           child: UserAccountsDrawerHeader(
  //             decoration: BoxDecoration(
  //               color: UniversalVariables.senderColor,
  //             ),
  //             accountName: Text(""),
  //             accountEmail: Text(""),
  //             currentAccountPicture: CircleAvatar(
  //                 backgroundImage: NetworkImage(
  //                     "https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/eggs-breakfast-avocado-1296x728-header.jpg?w=1155&h=1528")),
  //           ),
  //         ),
  //         ListTile(
  //           trailing: const Icon(
  //             Icons.arrow_forward_ios,
  //           ),
  //           leading: const Icon(
  //             Icons.home,
  //             color: UniversalVariables.darkBlueColor,
  //           ),
  //           title: const Text(
  //             'Home',
  //           ),
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //         ListTile(
  //           trailing: const Icon(
  //             Icons.arrow_forward_ios,
  //           ),
  //           leading: const Icon(
  //             Icons.shopping_basket,
  //             color: UniversalVariables.darkBlueColor,
  //           ),
  //           title: const Text('Cart'),
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => ChangeNotifierProvider(
  //                         create: (_) => CartPageBloc(), child: CartPage())));
  //           },
  //         ),
  //         ListTile(
  //           trailing: const Icon(
  //             Icons.arrow_forward_ios,
  //           ),
  //           leading: const Icon(
  //             Icons.fastfood,
  //             color: UniversalVariables.darkBlueColor,
  //           ),
  //           title: const Text('My Order'),
  //           onTap: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => MyOrderPage()));
  //           },
  //         ),
  //         ListTile(
  //           trailing: const Icon(
  //             Icons.arrow_forward_ios,
  //           ),
  //           leading: const Icon(
  //             Icons.clear,
  //             color: UniversalVariables.darkBlueColor,
  //           ),
  //           title: const Text('Logout'),
  //           onTap: () async {
  //             Navigator.pop(context);
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => LoginPage()));
  //             // final AuthMethods _authMethods = AuthMethods();
  //             // await _authMethods.logout();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  createPopularFoodList() {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text(
              "Popular Food ",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 200.0,
            child: homePageBloc.popularFoodList.length == -1
                ? Center(child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homePageBloc.popularFoodList.length,
                    itemBuilder: (_, index) {
                      return FoodTitleWidget(
                        homePageBloc.popularFoodList[index],
                      );
                    }),
          ),
        ],
      ),
    );
  }

  createSearchBar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(
            decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage())),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: const Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.black45),
                      ),
                    )),
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: UniversalVariables.darkBlueColor,
                            ),
                            onPressed: null)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  gotoCateogry(CategoryModel category) {
    null;
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => CategoryListPage(category)));
  }

  createListRecentlyAdd() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () => gotoCateogry(homePageBloc.recentlyCategory),
              child: const CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(
                    "https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/eggs-breakfast-avocado-1296x728-header.jpg?w=1155&h=1528",
                    scale: 60.0),
              )),
          GestureDetector(
              onTap: () => gotoCateogry(homePageBloc.recentlyCategory2),
              child: const CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(
                    "https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/eggs-breakfast-avocado-1296x728-header.jpg?w=1155&h=1528",
                    scale: 60.0),
              )),
          GestureDetector(
              onTap: () => gotoCateogry(homePageBloc.recentlyCategory3),
              child: const CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(
                    "https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/eggs-breakfast-avocado-1296x728-header.jpg?w=1155&h=1528",
                    scale: 60.0),
              )),
          GestureDetector(
              onTap: () => gotoCateogry(homePageBloc.recentlyCategory4),
              child: const CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(
                    "https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/eggs-breakfast-avocado-1296x728-header.jpg?w=1155&h=1528",
                    scale: 60.0),
              )),
        ],
      ),
    );
  }

  createFoodCategory() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: 200.0,
      child: homePageBloc.categoryList.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homePageBloc.categoryList.length,
              itemBuilder: (_, index) {
                return CategoryWidget(
                  homePageBloc.categoryList[index],
                );
              }),
    );
  }

  createForYou() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: homePageBloc.foodList.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: homePageBloc.foodList.length,
              itemBuilder: (_, index) {
                return FoodTitleWidget(homePageBloc.foodList[index]);
              }),
    );
  }
}
