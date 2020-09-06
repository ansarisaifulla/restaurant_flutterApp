import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
   final String categoryName;
 final String imagePath;
 final int numberOfItems;

 FoodCard(this.numberOfItems,this.imagePath,this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Row(
            children: [
              Image(
                image: AssetImage(imagePath),
                height: 65,
                width: 65,
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(categoryName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), Text(numberOfItems.toString()+" kinds")],
              )
            ],
          ),
        ),
      ),
    );
  }
}
