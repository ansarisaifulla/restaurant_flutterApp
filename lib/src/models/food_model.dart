
import 'dart:convert';

List<Food> modelFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

// String modelToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food{
  String id;
  String name;
  String imagePath;
  String category;
  String price;
  String discounts;
  String ratings;
  String desc;

 Food(this.id,this.name,this.imagePath,this.category,this.price,this.discounts,this.ratings,this.desc);
 Food.tp({this.id,this.name,this.imagePath,this.category,this.price,this.discounts,this.desc});

 factory Food.fromJson(Map<String, dynamic> json) => Food.tp(
        id: json["id"],
        name: json["name"],
        imagePath: json["imagepath"],
        category: json["category"],
        price:json["price"],
        discounts:json["discount"],
        desc:json["description"]
    );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imagePath": imagePath,
//         "category": category,
//     };
}