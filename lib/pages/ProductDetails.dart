import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tip/classes/Product_class.dart';
import 'package:project_tip/pages/Home_Page.dart';
import 'package:project_tip/pages/Shopping_cart.dart';


class ProductDetails extends StatefulWidget {

  final prod_name;
  final prod_price;
  final prod_brand;
  final prod_image;

ProductDetails({
  this.prod_name,
  this.prod_price,
  this.prod_brand,
  this.prod_image,

});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


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
            'Product details',
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
                Icons.shopping_cart,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.push(
                    context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Cart()));
              }),
        ],
      ),


      //============body============

      body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
//            decoration: BoxDecoration(
//            color: const Color(0x0D232F34),
//            ),

            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      child: GridTile(                      //Product Image
                        child: Container(
                          color: const Color(0xFFFFFFFF),
                          alignment: Alignment.topCenter,
                          child: Image.asset(widget.prod_image,
//                        fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //==========Product name and price===========

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x0D232F34),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                      border: (Border.all(color: const Color(0xFF344955), width: 3.0))
                    ),
                    child: ListTile(
                      title: Text(widget.prod_name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF344955),
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                            child: Text('${widget.prod_price}'' /month',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF344955),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.prod_brand}'' /month',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFFF9AA33),
                                  decoration: TextDecoration.lineThrough
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

//                Divider(color: const Color(0xB3344955),indent: 8.0,endIndent: 8.0,),
              SizedBox(height: 4.0,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){},
                          height: 50,
                          elevation: 0.0,
                          color:  const Color(0xFF344955),
                          textColor: const Color(0xFFF9AA33),
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                          child: Text('Buy Now',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          iconSize: 30.0,
                          color: const Color(0xFFF9AA33),
                          onPressed: (){
                            Fluttertoast.showToast(msg: 'Product added to cart');
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        iconSize: 30.0,
                        color: const Color(0xFFF9AA33),
                        onPressed: (){},
                      ),
                    ],
                  ),
                ),

                Divider(color: const Color(0xB3344955),indent: 8.0,endIndent: 8.0,),

                ListTile(
                  title: Text('Product Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),

                ),

                Divider(color: const Color(0xB3344955),indent: 8.0,endIndent: 8.0,),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Similar Products',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    child: Products(),
                  ),
                ),
                SizedBox(height: 70,)
              ],
            ),
          ),
      ),
    );
  }
}
