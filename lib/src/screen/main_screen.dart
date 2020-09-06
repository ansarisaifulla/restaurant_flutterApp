import 'package:flutter/material.dart';
import 'package:food_deliver/src/pages/favourite_page.dart';
import 'package:food_deliver/src/pages/order_page.dart';
import 'package:food_deliver/src/pages/home_page.dart';
import 'package:food_deliver/src/pages/profile_page.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


int currentTabIndex=0;
HomePage homePage;
Order order;
FavouritePage favouritePage;
ProfilePage profilePage;
List<Widget> pages;
Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePage=new HomePage();
    order=new Order();
    favouritePage=new FavouritePage();
    profilePage=new ProfilePage();
    pages=[homePage,order,favouritePage,profilePage];
    currentPage=homePage;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
            currentPage=pages[index];
          }); 
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home), title: Text("home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text("Orders")),
        BottomNavigationBarItem(
            icon: Icon(Icons.explore), title: Text("Explore")),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("profile"))
      ]),
      body: currentPage,
      
    );
  }
}

// appBar: currentTabIndex==1?AppBar(
//         title: Text(
//           "Your food cart",
//           style: TextStyle(color: Colors.black),
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ):null,
