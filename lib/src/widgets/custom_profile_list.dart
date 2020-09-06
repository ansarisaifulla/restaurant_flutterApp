import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
final IconData icon;
final String text;

CustomListTile(this.icon,this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
          child: Row(children: [
        Icon(icon),
        SizedBox(width: 15.0,),
        Text(text,style: TextStyle(fontSize: 16.0,color: Colors.black38),)
      ],),
    );
  }
}