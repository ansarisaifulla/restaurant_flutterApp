import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddFoodItem extends StatefulWidget {
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  File _image;
  final picker = ImagePicker();

  String title, category, description, price, discount;
  GlobalKey<FormState> _foodItemKey = GlobalKey();

  Future chooseImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }
 Future uploadImage()async{

   final uri=Uri.parse("http://192.168.0.103/flutter/uploadFood.php");
   
   var request=http.MultipartRequest('POST',uri);
   request.fields['title']=title;
   request.fields['category']=category;
   request.fields['description']=description;
   request.fields['price']=price;
   request.fields['discount']=discount;
   var pic=await http.MultipartFile.fromPath("image", _image.path);
   request.files.add(pic);
   var response=await request.send();
   if(response.statusCode==200)
   {
     print("image uploaded");
   }
   else
   {
     print("image not uploaded");
   }

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.only(left: 13.0, right: 13.0),
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              GestureDetector(
                onTap: chooseImage,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image:
                           _image == null?
                               AssetImage("assets/images/noimage.png")
                              : FileImage(_image),
                          fit: BoxFit.cover)),
                ),
              ),
              Form(
                  key: _foodItemKey,
                  child: Column(
                    children: [
                      _buildTextFormField("Food Title"),
                      _buildTextFormField("Category"),
                      _buildTextFormField("Description", maxline: 4),
                      _buildTextFormField("Price"),
                      _buildTextFormField("Discount"),
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_foodItemKey.currentState.validate()) {
                            _foodItemKey.currentState.save();
                            uploadImage();
                          }
                        },
                        child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Center(
                                child: Text(
                              "Add Food Item",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                          ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String hint, {int maxline = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: hint),
      maxLines: maxline,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        String errMsg;
        if (value.isEmpty && hint == "Food Title") {
          errMsg = "food title is required";
        }
        if (value.isEmpty && hint == "Category") {
          errMsg = "Category is required";
        }
        if (value.isEmpty && hint == "Description") {
          errMsg = "Description is required";
        }
        if (value.isEmpty && hint == "Price") {
          errMsg = "Price is required";
        }
        if (value.isEmpty && hint == "Discount") {
          errMsg = "Discount is required";
        }
        return errMsg;
      },
      onChanged: (String value) {
        if (hint == "Food Title") {
          title = value;
        }
        if (hint == "Category") {
          category = value;
        }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }
}
