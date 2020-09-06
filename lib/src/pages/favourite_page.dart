import 'package:food_deliver/src/models/food_model.dart';
import 'package:food_deliver/src/pages/food_detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/explore_food_item.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Food> foods;
  @override
  void initState() { 
    super.initState();
    allFoodItem();
    
  }
   allFoodItem() async {
    var url = "http://192.168.0.104/flutter/getAllFood.php";
    var response = await http.get(url);
    setState(() {
      foods=modelFromJson(response.body);
    });
    // return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "All food items",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: 
        // FutureBuilder(
        //     future: allFoodItem(),
        //     builder: (context, snapshot) {
        //       // if(snapshot.hasError) print
        //       return snapshot.hasData
                  foods==null
                  ?Center(
                      child: CircularProgressIndicator(),
                    ): ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (BuildContext context, int index) {
                        // List list=snapshot.data;
                        Food f=foods[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext) => FoodDetailsPage(
                                      food: f)));
                            },
                            child: ExploreFoodCard(
                                f.name,
                                f.desc,
                                f.imagePath,
                                f.price
                          ),
                        ));
                      },
                    )
                  
            // })
            );
  }
}
