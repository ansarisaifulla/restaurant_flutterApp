import 'package:flutter/material.dart';
import 'package:food_deliver/src/data/category_data.dart';
import 'package:food_deliver/src/models/category_model.dart';
import 'package:food_deliver/src/pages/categorywise_food.dart';


class FoodCategory extends StatefulWidget {
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}
// FoodCard(_categories[index].numberOfItems,
//                             _categories[index].imagePath,
//                             _categories[index].categoryName)
class _FoodCategoryState extends State<FoodCategory> {
     List<Category> _categories = categories;
    @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>CategoryWiseList( category:_categories[index].categoryName)));
            },
                      child: Container(
      margin: EdgeInsets.only(right: 14.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Row(
            children: [
              Image(
                image: AssetImage(_categories[index].imagePath),
                height: 65,
                width: 65,
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(_categories[index].categoryName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), Text(_categories[index].numberOfItems.toString()+" kinds")],
              )
            ],
          ),
        ),
      ),
    )
          );
        },
      ),
    );
  }
}
