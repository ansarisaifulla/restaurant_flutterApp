import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ExploreFoodCard extends StatefulWidget {

final String image,title,desc,price;

ExploreFoodCard(this.title,this.desc,this.image,this.price);

  @override
  _ExploreFoodCardState createState() => _ExploreFoodCardState();
}

class _ExploreFoodCardState extends State<ExploreFoodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.30,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.black26,
                offset: Offset(0.0, 2.0))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              // margin: EdgeInsets.only(left: 10.0),
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      // image: AssetImage("assets/images/breakfast.jpeg"),
                      // http://192.168.0.103/flutter/uploadFood.php
                      image: NetworkImage("http://192.168.0.104/flutter/uploads/"+widget.image),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: AutoSizeText(
                        widget.desc,
                        style: TextStyle(fontSize: 16.0),
                        maxLines: 4,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.price+" rs",
                          style: TextStyle(color: Colors.blue),
                        ),
                        // Spacer(),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: 43.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.blue)),
                          child: Center(
                            child: Text("buy",style: TextStyle(fontSize: 15.0),),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
