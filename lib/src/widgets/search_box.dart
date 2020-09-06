import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(30.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              border: InputBorder.none,
              suffixIcon: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(25),
                  child: Icon(Icons.search, color: Colors.black)),
              hintText: "Search item"),
        ));
  }
}
