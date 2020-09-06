import 'package:flutter/material.dart';
import 'package:food_deliver/src/admin/pages/add_food_item.dart';
import 'package:http/http.dart' as http;
import 'package:food_deliver/src/pages/login_page.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<SignUpPage> {
  final r_key = GlobalKey<FormState>();
  String name, email, mobile, pass, confirm;
  // final nameController = TextEditingController();
  // final emailController = TextEditingController();
  // final mobileController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // initialize();
  }

  // void initialize() async {
  //   await Firebase.initializeApp();
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   nameController.dispose();
  //   emailController.dispose();
  //   mobileController.dispose();
  //   passwordController.dispose();
  //   confirmController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        backgroundColor: Colors.green[400],
        elevation: 0.5,
        
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/register.png"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                  child: Form(
                      key: r_key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.black),
                                // ),
                                labelText: "Name",
                                prefixIcon: Icon(Icons.person),
                                labelStyle: TextStyle(fontSize: 16.0),
                                hintText: "enter name"),
                                
                            onChanged: (String value) {
                              name = value;
                            },
                            validator: (String value) {
                              return value.isEmpty ? "enter password" : null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.black),
                                // ),
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                                labelStyle: TextStyle(fontSize: 16.0),
                                hintText: "enter email"),
                            onChanged: (String value) {
                              email = value;
                            },
                            validator: (String value) {
                              return value.isEmpty ? "enter password" : null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.black),
                                // ),
                                labelText: "Ph no.",
                                prefixIcon: Icon(Icons.phone),
                                labelStyle: TextStyle(fontSize: 16.0),
                                hintText: "enter number"),
                            onChanged: (String value) {
                              mobile = value;
                            },
                            validator: (String value) {
                              return value.isEmpty ? "enter password" : null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.black),
                                // ),
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: TextStyle(fontSize: 16.0),
                                hintText: "enter password"),
                            onChanged: (String value) {
                              pass = value;
                            },
                            obscureText: true,
                            validator: (String value) {
                              return value.isEmpty ? "enter password" : null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.black),
                                // ),
                                labelText: "Confirm",
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: TextStyle(fontSize: 16.0),
                                hintText: "retype password"),
                            onChanged: (String value) {
                              confirm = value;
                            },
                            obscureText: true,
                            validator: (String value) {
                              return pass != confirm ? "enter password" : null;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account?",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext) =>
                                                LoginPage()));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontSize: 18.0),
                                  ))
                            ],
                          ),
                          Center(
                            child: RaisedButton(
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 21.0, vertical: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: ()  async{
                                if (r_key.currentState.validate()) {
                                  r_key.currentState.save();
                                  var data=await register(name, email, mobile, pass);
                                  // ignore: unrelated_type_equality_checks
                                  if(data == "Data registered succcessfully"){

                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>LoginPage()));
                                  }
                                  else{
                                    Toast.show("Email already exists", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                  }
                                }
                              },
                              color: Colors.green,
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 21.0,color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
  Future<String> register(String name,String email,String mobile,String pass) async{
  String url="http://192.168.0.104/flutter/register.php";
  final response=await http.post(url,
  // headers:{'Accept':'Application/json'},
  body:{'name':name,'email':email,'mobile':mobile,'password':pass});
  print("response is here::"+response.body);
  String convertedData=response.body;
  if(convertedData=="Data registered succcessfully")
  {
    print("response is hereeeeee::"+response.body);
  }
  // convertedData.data;
  // var convertedData=json.decode(response.body);
  return convertedData;
}
}
