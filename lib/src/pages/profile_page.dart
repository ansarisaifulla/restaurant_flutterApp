import 'package:food_deliver/src/models/user_model.dart';
import 'package:food_deliver/src/pages/edit_profile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:food_deliver/src/widgets/custom_profile_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnNotificationOn = false;
  bool turnLocationOn=true;
  // List<User> users;
  String userid;
  User user;
  var _imagePath;
  @override
  void initState() { 
    super.initState();
    getProfileData();
    loadImage();
  }
  Future getProfileData() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
       userid=sharedPreferences.getString("userid");  
    var response=await http.get("http://192.168.0.104/flutter/profileData.php?userid=${userid}");
    var data=json.decode(response.body);
    setState(() {
      user=User(id: data[0]["id"],
                name: data[0]["name"],
                email: data[0]["email"],
                mobile: data[0]["mobile"],
                passsword: data[0]["passsword"],
                address: data[0]["address"]);
    });  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
          child: user==null? Center(
                  child: CircularProgressIndicator(),
                ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black38,
                              offset: Offset(0, 4.0))
                        ],
                        // image: DecorationImage(
                        //     image: AssetImage("assets/images/breakfast.jpeg"),
                        //     fit: BoxFit.cover)
                        ),
                        child:CircleAvatar(
                backgroundImage: _imagePath != null
                    ? FileImage(File(_imagePath))
                    : AssetImage("assets/images/noimage.png"),
                radius: 60,
              ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${user.name}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Text(
                        "${user.email}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>EditProfile(user:user)));
                        },
                                              child: Container(
                          height: 25.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.blue)),
                              child: Center(child: Text("edit"),),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, bottom: 12.0, top: 20.0),
                child: Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Column(
                    children: [
                      CustomListTile(Icons.location_on, "${user.address}"),
                      Divider(),
                      CustomListTile(Icons.lock ,"change password"),
                      Divider(),
                      CustomListTile(Icons.local_shipping, "shipping"),
                      Divider(),
                      CustomListTile(Icons.payment, "payment"),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 20.0),
                child: Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0,right: 12.0),
                  child: Column(
                    children: [
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Notifications",style: TextStyle(fontSize: 16.0,color: Colors.black54),),
                          Switch(
                              value: turnNotificationOn,
                              onChanged: (bool value) {
                                setState(() {
                                  turnNotificationOn = value;
                                });
                              })
                        ],
                      ),
                      Divider(),
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Location tracking",style: TextStyle(fontSize: 16.0,color: Colors.black54),),
                          Switch(
                              value: turnLocationOn,
                              onChanged: (bool value) {
                                setState(() {
                                  turnLocationOn = value;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void loadImage() async
   {
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     setState(() {
       _imagePath=sharedPreferences.getString("profilePath");
     });
    //  print("image path is this :"+_imagePath);

   }
}
