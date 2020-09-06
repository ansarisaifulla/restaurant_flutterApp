import 'package:flutter/material.dart';
import 'package:food_deliver/src/models/food_model.dart';

class OrderCard extends StatefulWidget {
  Food food;
  OrderCard(this.food);
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFFD3D3D3)),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  InkWell(onTap: () {}, child: Icon(Icons.keyboard_arrow_up)),
                  Text("0"),
                  InkWell(onTap: () {}, child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/lunch.jpeg"),
                      fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(35.0)
                      ),
            ),
            SizedBox(width: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Grilled chicken",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 5.0,),
              Text("3.0",style: TextStyle(fontSize: 16,color: Colors.orangeAccent),),
            ],),
            Spacer(),
            GestureDetector(
              onTap: (){},
              child: Icon(Icons.cancel,color: Colors.grey,))
          ],
        ),
      ),
    );
  }
}
