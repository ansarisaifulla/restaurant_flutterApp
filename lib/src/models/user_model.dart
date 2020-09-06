import 'dart:convert';

List<User> userModelFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User{
  String id;
  String name;
  String email;
  String mobile;
  String passsword;
  String address;
  User({this.id,this.name,this.email,this.mobile,this.passsword,this.address});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        passsword:json["password"],
        address:json["address"]
    );
}