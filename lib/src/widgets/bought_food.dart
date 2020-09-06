import 'package:flutter/material.dart';

class BoughtFoods extends StatefulWidget {
   final String id;
 final String name;
 final String imagePath;
 final String category;
 final String price;
 final String discounts;
 final String ratings;

 BoughtFoods(this.id,this.name,this.imagePath,this.category,this.price,this.discounts,this.ratings);
  @override
  _BoughtFoodsState createState() => _BoughtFoodsState();
}

class _BoughtFoodsState extends State<BoughtFoods> {
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
          child: Stack(
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.85,
            // child: Image.asset(widget.imagePath,fit:BoxFit.cover),
            child:Image.network("http://192.168.0.104/flutter/uploads/${widget.imagePath}",fit: BoxFit.cover,),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 45.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black12],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 16,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 16,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 16,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 16,),
                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 16,),
                      SizedBox(width: 15.0,),
                      Text(widget.ratings.toString()+" reviews",style: TextStyle(color: Colors.grey,fontSize: 16),)
                    ],)
                  ],
                ),
                Column(
                  children: [
                  Text(widget.price.toString(),style: TextStyle(color: Colors.orangeAccent)),
                  Text("Min. order",style: TextStyle(color: Colors.grey)),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
