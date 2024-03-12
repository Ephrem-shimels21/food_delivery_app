import 'package:flutter/material.dart';
import 'package:food_delivery_app/food/model/food_model.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/food/bloc/food_detail_page_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/food/widget/food_title_widget.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodModel food;
  FoodDetailPage({required this.food});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FoodDetailPageBloc(),
        child: FoodDetailPageContent(
          food,
        ));
  }
}

class FoodDetailPageContent extends StatefulWidget {
  final FoodModel fooddata;
  FoodDetailPageContent(this.fooddata);

  @override
  _FoodDetailPageContentState createState() => _FoodDetailPageContentState();
}

class _FoodDetailPageContentState extends State<FoodDetailPageContent> {
  late FoodDetailPageBloc foodDetailPageBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String sampleDescription =
      "The existence of the Positioned forces the Container to the left, instead of centering. Removing the Positioned, however, puts the Container in the middle-center";
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // foodDetailPageBloc.getPopularFoodList();
      foodDetailPageBloc.generateRandomRating();
    });
  }

  @override
  Widget build(BuildContext context) {
    foodDetailPageBloc = Provider.of<FoodDetailPageBloc>(context);
    foodDetailPageBloc.context = context;

    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Hero(
                    tag: "avatar_${widget.fooddata.keys.toString()}",
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.bottomLeft,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(80.0)),
                        image: DecorationImage(
                            image: NetworkImage(widget.fooddata.image),
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
                                  end: Alignment.topCenter),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  "${foodDetailPageBloc.rating}★",
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
                createdetails(),
                createPopularFoodList(),
              ],
            ),
          ),
        ));
  }

  createdetails() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              widget.fooddata.name,
              style: const TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  color: UniversalVariables.blueColor),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    "${widget.fooddata.price}birr",
                    style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: UniversalVariables.blueColor),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 18.0),
                  decoration: const BoxDecoration(
                      color: UniversalVariables.blueColor,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: Row(
                    children: <Widget>[
                      foodDetailPageBloc.mItemCount != 1
                          ? IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: () =>
                                  foodDetailPageBloc.decreamentItems(),
                            )
                          : const IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: null,
                            ),
                      Text(
                        foodDetailPageBloc.mItemCount.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          icon: const Icon(Icons.add,
                              color: Colors.white, size: 30.0),
                          onPressed: () => foodDetailPageBloc.increamentItems())
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  sampleDescription,
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                )),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RatingBar(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  // do nothing XD
                },
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: Colors.amber),
                  half: const Icon(Icons.star_half, color: Colors.amber),
                  empty: const Icon(Icons.star_border, color: Colors.amber),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(UniversalVariables.blueColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                ),
                onPressed: () => foodDetailPageBloc.addToCart(widget.fooddata),
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  createPopularFoodList() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Popular Food ",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 200.0,
            child: foodDetailPageBloc.foodList.length == -1
                ? Center(child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodDetailPageBloc.foodList.length,
                    itemBuilder: (_, index) {
                      return FoodTitleWidget(
                        foodDetailPageBloc.foodList[index],
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
