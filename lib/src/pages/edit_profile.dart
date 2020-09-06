import 'package:flutter/material.dart';
import 'package:food_deliver/src/models/user_model.dart';
import 'package:food_deliver/src/screen/main_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
   final User user;
  EditProfile({this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  String _imagePath;
  GlobalKey<FormState> _editkey = GlobalKey();
  String name, email, address, password, mobile;

@override
void initState() { 
  super.initState();
  name=widget.user.name;
  email=widget.user.email;
  mobile=widget.user.mobile;
  address=widget.user.address;
  // password=widget.user.passsword;
  loadImage();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: _imagePath!=null?
                  CircleAvatar(
                backgroundImage:
                    FileImage(File(_imagePath))
                    ,
                radius: 60,
              ): CircleAvatar(
                backgroundImage: _image != null
                    ? FileImage(_image)
                    : AssetImage("assets/images/noimage.png"),
                radius: 60,
              )),
              Center(
                  child: OutlineButton(
                      child: Text(
                        "set profile image",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                      color: Colors.black)),
              Form(
                key: _editkey,
                child: Column(
                  children: [
                    _buildEditFormField("Name"),
                    _buildEditFormField("Email"),
                    _buildEditFormField("Mobile"),
                    // _buildEditFormField("Password"),
                    _buildEditFormField("Address"),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () async{
                        if (_editkey.currentState.validate()) {
                          _editkey.currentState.save();
                          print("name: ${email}");
                          var response =await http.post("http://192.168.0.104/flutter/updateProfile.php",
                          body: {'userid':widget.user.id,'name':name,'email':email,'mobile':mobile,'address':address});
                          if(response.body=="updated successfully")
                          {
                            Toast.show("updated successfully", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                          else if(response.body=="could not update")
                          {
                            Toast.show("could not update", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                          else 
                          {
                            Toast.show("server error", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>MainScreen()));

                        }
                      },
                      child: Text("Save"),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditFormField(String label) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "enter ${label}",
          hintStyle: TextStyle(color: Colors.grey),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black)),
          // obscureText: label=="Password"?true:false,
      keyboardType:
          label == "Mobile" ? TextInputType.number : TextInputType.text,
          initialValue:label=="Name"?widget.user.name
                        :label=="Address"?widget.user.address
                        :label=="Email"?widget.user.email
                        :label=="Mobile"?widget.user.mobile
                        :widget.user.passsword,
      onChanged: (String value) {
        if (label == "Name") name = value;
        if (label == "Address") address = value;
        if (label == "Mobile") mobile = value;
        if (label == "Email") email = value;
        if (label == "Password") password = value;
      },
      validator: (String value) {
        String errMsg;
        if (value.isEmpty && label == "Name") {
          errMsg = "name is required";
        }
        if (value.isEmpty && label == "Address") {
          errMsg = "Address is required";
        }
        if (value.isEmpty && label == "Email") {
          errMsg = "email is required";
        }
        if (value.isEmpty && label == "Mobile") {
          errMsg = "mobile no. is required";
        }
        if (value.isEmpty && label == "Password") {
          errMsg = "password is required";
        }
        // if (label == "Mobile" && value.length != 10) {
        //   errMsg = "invalid mobile no";
        // }
        if (label == "Email" && !value.contains("@gmail.com")) {
          errMsg = "invalid email id";
        }
        return errMsg;
      },
    );
  }

   void pickImage() async {
    var pickeImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickeImage.path);
    });
    saveImage(_image.path);
  }
   void saveImage(path) async{
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     sharedPreferences.setString("profilePath",path);
   }
   void loadImage() async
   {
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     setState(() {
      _imagePath =sharedPreferences.getString("profilePath");
     });
     print("image path is this :${_imagePath}");

   }
}
