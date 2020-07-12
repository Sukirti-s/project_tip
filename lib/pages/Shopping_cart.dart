import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tip/pages/Home_Page.dart';
import 'package:project_tip/classes/Cart_Products.dart';


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF232F34),
        centerTitle: true,
        title: InkWell(
          onTap: (){
            Navigator.pushReplacement(
                context, new MaterialPageRoute(
                builder: (BuildContext context) => new Homepage()));
          },
          child: Text(
            'Cart',
            style: TextStyle(
              fontSize: 22.0,
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {}),
        ],
      ),

      bottomNavigationBar: Container(              //Bottom navigator
        color: const Color(0x0D232F34),
        child: Row(
          children: <Widget>[
            Expanded(                              //total amount
              child: ListTile(
                title: Text('Total:',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: const Color(0xFF232F34),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('Rs. 9750',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: const Color(0xFF232F34),
                  ),
                ),
              ),
            ),
            Expanded(                              //check out button
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: (){},
                  height: 50,
                  elevation: 0.0,
                  color:  const Color(0xFF232F34),
                  textColor: const Color(0xFFF9AA33),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  child: Text('Check Out',style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      body: CartProducts(),
    );
  }
}
