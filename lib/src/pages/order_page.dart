import 'package:food_deliver/src/models/cart_food_model.dart';
import 'package:food_deliver/src/models/food_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:food_deliver/src/pages/login_page.dart';
import 'package:food_deliver/src/widgets/order_card.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<CartFood> cartFoods;
  String userid;
  double total = 0;
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    allCartItem();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerSuccess(PaymentSuccessResponse response) {

    Toast.show("payment successfull", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void handlerFailure(PaymentFailureResponse response) {
    Toast.show("payment failed", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Toast.show("external wallet used", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void checkout() {
    var options = {
      "key": "rzp_test_yuAU08GEUwXDHd",
      "amount": total*100,
      "name": "Food deliver app",
      "description": "Payment for dummy items",
      "prefill": {
        "contact": "8983533142",
        "email": "ansarisaifulla7@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  allCartItem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userid = sharedPreferences.getString("userid");
    var url =
        "http://192.168.0.104/flutter/getAllCartItem.php?userid=${userid}";
    var response = await http.get(url);
    setState(() {
      cartFoods = CartmodelFromJson(response.body);
    });
    getTotalCartValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //here we used scaffold cz we wanted appbar in order page
      appBar: AppBar(
        title: Text(
          "Your food cart",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            cartFoods == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: cartFoods.map(_buildCartList).toList(),
                  ),
            // OrderCard(),OrderCard(),
            _buildTotalContainer()
          ],
        ),
      ),
    );
  }
  // add bottom navigation and set it to _buildTotalContainer
  // so that it will be fixed in bottom and dont forget to set height of container in
// _buildTotalContainer so that after adding no. of card ,the bottom price will be fixed and only order cards will scroll

  getTotalCartValue() {
    total=0;
    CartFood obj;
    if(cartFoods==null)
    {
      total=0;
    }
    for (obj in cartFoods) {
      total += double.parse(obj.price) * double.parse(obj.quantity);
    }
  }

  Widget _buildCartList(CartFood food) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 45,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFFD3D3D3)),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  InkWell(onTap: () {}, child: Icon(Icons.keyboard_arrow_up)),
                  Text("${food.quantity}"),
                  InkWell(onTap: () {}, child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://192.168.0.104/flutter/uploads/${food.imagepath}"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(35.0)),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${food.name}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "3.0",
                  style: TextStyle(fontSize: 16, color: Colors.orangeAccent),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
                onTap: () async {
                  var response = await http.get(
                      "http://192.168.0.104/flutter/deleteCartItem.php?id=${food.cartid}");
                  if (response.body == "Item removed") {
                    allCartItem();
                    Toast.show("Item removed", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  } else {
                    Toast.show("could not remove", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  }
                  // http://192.168.0.104/flutter/deleteCartItem.php?id=6
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildTotalContainer() {
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cart Total",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  total.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  "50",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tax",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  "50",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            Divider(
              height: 40.0,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  total.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: GestureDetector(
                onTap: checkout,
                child: Container(
                  width: MediaQuery.of(context).size.width * 70,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      "Proceed to Checkout",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
