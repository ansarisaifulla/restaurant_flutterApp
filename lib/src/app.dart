import 'package:flutter/material.dart';
import 'package:food_deliver/src/pages/login_page.dart';

class MyApp extends StatelessWidget {
  // FoodModel foodModel = new FoodModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food delivery app",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: LoginPage(),
    );
  }
}
