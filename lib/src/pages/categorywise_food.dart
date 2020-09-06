import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_deliver/src/models/food_model.dart';
import 'package:food_deliver/src/pages/food_detail_page.dart';
import 'package:food_deliver/src/widgets/explore_food_item.dart';
import 'package:http/http.dart' as http;

class CategoryWiseList extends StatefulWidget {
  final String category;
  CategoryWiseList({this.category});
  @override
  _CategoryWiseListState createState() => _CategoryWiseListState();
}

class _CategoryWiseListState extends State<CategoryWiseList> {
  List<Food> foods;
  @override
  void initState() {
    super.initState();
    allFoodItem();
  }

  allFoodItem() async {
    var url = "http://192.168.0.104/flutter/getCategorywiseFood.php?category=${widget.category}";
    var response = await http.get(url);
    setState(() {
      foods = modelFromJson(response.body);
    });
    // return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Items",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: foods == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 10.0),
            child: ListView.builder(
                itemCount: foods.length,
                itemBuilder: (BuildContext context, int index) {
                  // List list=snapshot.data;
                  Food f = foods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext) =>
                              FoodDetailsPage(food: f)));
                    },
                    child:
                        ExploreFoodCard(f.name, f.desc, f.imagePath, f.price),
                  );
                },
              ),
          ),
    );
  }
}
