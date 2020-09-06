import 'dart:convert';

List<CartFood> CartmodelFromJson(String str) => List<CartFood>.from(json.decode(str).map((x) => CartFood.fromJson(x)));

class CartFood{
  String id;
  String cartid;
  String name;
  String imagepath;
  String desc;
  String price;
  String discount;
  String quantity;
  String category;

  CartFood({this.id,this.cartid,this.name,this.imagepath,this.category,this.price,this.discount,this.desc,this.quantity});

  
 factory CartFood.fromJson(Map<String, dynamic> json) => CartFood(
        id: json["id"],
        cartid: json["cartid"],
        name: json["name"],
        imagepath: json["imagepath"],
        category: json["category"],
        price:json["price"],
        discount:json["discount"],
        desc:json["description"],
        quantity: json["quantity"]
    );
}