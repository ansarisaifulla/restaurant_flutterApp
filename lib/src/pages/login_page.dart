import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_deliver/src/admin/pages/add_food_item.dart';
import 'package:food_deliver/src/pages/signup.dart';
import 'package:food_deliver/src/screen/main_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';


ProgressDialog pr;

// ignore: non_constant_identifier_names
class LoginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
 

  String _email, _password;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            // Image.asset("assets/img_up.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 5.0),
                                  blurRadius: 5.0),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -5.0),
                                  blurRadius: 5.0)
                            ]),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0),
                                  ),
                                  OutlineButton(
                                    onPressed: () {},
                                    child: Text("login with google"),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintText: "enter email",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                                onChanged: (String value) {
                                  _email = value;
                                },
                                // controller: usernameController,
                                validator: (String text) {
                                  return text.isEmpty ? "enter username" : null;
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintText: "enter password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                                // controller: passwordController,
                                onChanged: (String value) {
                                  _password = value;
                                },
                                validator: (String text) {
                                  return text.isEmpty ? "enter password" : null;
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton.icon(
                                      color: Colors.lightGreen,
                                      onPressed: ()  async{
                                        if (_key.currentState.validate()) {
                                          _key.currentState.save();
                                         var data=await login(_email,_password);
                                         print("heyyyyyyyyyyyyyyyy"+data);
                                         pr.show();
                                         if(data=="invalid email")
                                         {
                                           setState(() {
                                             pr.hide();
                                           });
                                           Toast.show("Email not found", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                         }
                                         else if(data=="login not successfull")
                                         {
                                           pr.hide();
                                           Toast.show("oops sorry server error", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                         }
                                         else
                                         {
                                           
                                           SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
                                           sharedPreferences.setString("userid", data);
                                          //  String x=sharedPreferences.getString("userid");
                                        // Toast.show("userid is ${x}", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);

                                        //    print("data is here "+data);
                                           pr.hide();
                                           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>MainScreen()));
                                         }
                                        }
                                      },
                                      icon: Icon(Icons.arrow_right),
                                      label: Text("Login")),
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.green),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "New User?",
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext) => SignUpPage()));
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.lightGreen,
                                Colors.greenAccent
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Center(
                            child: Text("SIGN-UP"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
            Image.asset(
              "assets/images/img_down.png",
              height: MediaQuery.of(context).size.height * 0.15,
            )
          ],
        ),
      ),
    );
  }
  Future login(String username, String password) async {
  String url = "http://192.168.0.104/flutter/login.php";
  final response = await http.post(url,
      // headers: {'Accept': 'Application/json'},
      body: {'email': username, 'password': password});
      var convertedData=response.body;
      return convertedData;
}
}
