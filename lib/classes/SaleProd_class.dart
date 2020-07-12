import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tip/pages/ProductDetails.dart';

class SaleProducts extends StatefulWidget {
  @override
  _SaleProductsState createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {


  var product_list = [
    {
      "name": "Laptop",
      "pic" : "assets/laptop3.png",
      "price": 48000/DateTime.monthsPerYear,
      "old_price": 54000/DateTime.monthsPerYear
    },
    {
      "name": "Headphone",
      "pic" : "assets/headphone2.png",
      "price": 6000/DateTime.monthsPerYear,
      "old_price": 9000/DateTime.monthsPerYear
    },
    {
      "name": "Camera Set",
      "pic" : "assets/camera2.jpg",
      "price": 60000/DateTime.monthsPerYear,
      "old_price": 72000/DateTime.monthsPerYear
    },
    {
      "name": "Speaker",
      "pic" : "assets/speaker1.jpg",
      "price": 3000/DateTime.monthsPerYear,
      "old_price": 6000/DateTime.monthsPerYear
    },
  ];

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      itemCount: product_list.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 5),
      itemBuilder: (BuildContext context, int index){
        return singleProd(
          name: product_list[index]['name'],
          pic: product_list[index]['pic'],
          price: product_list[index]['price'],
          oldprice: product_list[index]['old_price'],
        );
      },
    );
  }
}

class singleProd extends StatelessWidget {
  final name;
  final pic;
  final price;
  final oldprice;

  singleProd({
    this.name,
    this.pic,
    this.price,
    this.oldprice,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
//          shadowColor: const Color(0xFFF9AA33),
          elevation: 0.0,
          child: Hero(
            tag: Text('Hero'),
            child: Material(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context, new MaterialPageRoute(
                      builder: (BuildContext context) => ProductDetails( // passing values of the prod to product detail page
                        prod_name: name,
                        prod_price: price,
                        prod_brand: oldprice,
                        prod_image: pic,
                      )));
                },


                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GridTile(
                    footer: Container(
                      color: const Color(0xBFFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
//                            Text("Rate: ""$oldprice",
//                              style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 13.0,
//                                color: Colors.black,
//                                  decoration: TextDecoration.lineThrough
//                              ),
//                            ),
                            Text("Sale Price: ""$price",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.red[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    child: Image.asset(pic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
