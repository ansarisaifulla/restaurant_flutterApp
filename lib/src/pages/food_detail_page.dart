import 'dart:ui';
import 'package:food_deliver/src/pages/order_page.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/src/models/food_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FoodDetailsPage extends StatefulWidget {
  Food food;
  FoodDetailsPage({this.food});

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {

 int total_amt;
String userid;
String foodid;
@override
void initState() { 
  super.initState();
  total_amt=int.parse(widget.food.price);
  foodid=widget.food.id;
  getUserId();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Food details",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://192.168.0.104/flutter/uploads/${widget.food.imagePath}"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.food.name,
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                ),
                Text(
                  "Rs.${widget.food.price} ",
                  style: TextStyle(
                      fontSize: 17.0, color: Theme.of(context).primaryColor),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Description:",
              style: TextStyle(color: Colors.black, fontSize: 17.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              textAlign: TextAlign.justify,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: increase,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      Text(
                        "1",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: decrease,
                      ),
                    ],
                  ),
                ),
                Text(
                  // total_amt.isEmpty?"${widget.food.price}":"${total_amt}",
                  "Rs."+total_amt.toString(),
                  style: TextStyle(color: Colors.orange, fontSize: 17.0),
                )
              ],
            ),
            Center(
              child: InkWell(
                onTap: ()async{
                  
                  var data=await addToCart();
                  if(data=="Item added to cart")
                  {
                    Toast.show("Item added to cart successfully", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>Order()));
                  }
                  else if(data=="Item already added in cart")
                  {
                     Toast.show("Item already in cart", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                  }
                  else if(data=="Item updated to cart")
                  {
                     Toast.show("Item updated to cart", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                  }
                  else
                  {
                    Toast.show("oops server error", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top:25),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
   Future addToCart() async{
  String url="http://192.168.0.104/flutter/addToCart.php";
  int tmp=total_amt~/int.parse(widget.food.price);
  String quan=tmp.toString();
  final response=await http.post(url,
  body:{'userid':userid,'foodid':foodid,'quantity':quan});
  print("response is here::"+response.body);
  var convertedData=response.body;
  return convertedData;
}
  getUserId() async{
     SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
       userid=sharedPreferences.getString("userid");
       
  }
  void increase()
  {
      setState(() {
        total_amt=total_amt+int.parse(widget.food.price);
      });
  }
  void decrease()
  {
      setState(() {
        if(total_amt>int.parse(widget.food.price))
        {
          total_amt=total_amt-int.parse(widget.food.price);
        }
        
      });
  }

}
