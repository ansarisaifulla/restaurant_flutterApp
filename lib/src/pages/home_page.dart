import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:food_deliver/src/data/food_data.dart';
import 'package:food_deliver/src/pages/food_detail_page.dart';
import 'package:food_deliver/src/widgets/bought_food.dart';
import 'package:food_deliver/src/widgets/food_category.dart';
import 'package:food_deliver/src/widgets/search_box.dart';
import '../admin/pages/add_food_item.dart';
import '../models/food_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Food> f;
  @override
  void initState() {
    super.initState();
    allFoodItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [IconButton(icon: Icon(Icons.notifications,color: Colors.white,), onPressed: () { print("hello"); },)],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Saifulla Ansari",
              style: TextStyle(fontSize: 17),
            ),
            accountEmail: Text("ansarisaifulla7@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Text(
                "S",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Item"),
            trailing: Image.asset('assets/google.png', width: 35, height: 35),
            onTap: () {
           
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext) => AddFoodItem()));
            },
          ),
        ],
      )),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 15),
        children: [
          SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      // height: MediaQuery.of(context).size.width * 0.12,
                      child: AutoSizeText(
                        "What would you like to eat?",
                        style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
          FoodCategory(),
          SizedBox(
            height: 20.0,
          ),
          SearchField(),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frequently bought food",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              GestureDetector(
                onTap: () {},
                child: Text("View all",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.orangeAccent)),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          f == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: f.map(_buildFoodItem).toList(),
                )
        ],
      ),
    );
  }

  allFoodItem() async {
    var url = "http://192.168.0.104/flutter/getAllFood.php";
    var response = await http.get(url);
    setState(() {
      f = modelFromJson(response.body);
    });
  }

  Widget _buildFoodItem(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext) => FoodDetailsPage(food: food)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: BoughtFoods(food.id, food.name, food.imagePath, food.category,
            food.price, food.discounts, "12.0"),
      ),
    );
  }
}
