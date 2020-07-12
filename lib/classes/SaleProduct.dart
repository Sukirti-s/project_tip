import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/classes/ProductProvider.dart';
import 'package:project_tip/pages/ProductDetails.dart';
import 'package:provider/provider.dart';

class SaleProd extends StatefulWidget {
  @override
  _SaleProdState createState() => _SaleProdState();
}

class _SaleProdState extends State<SaleProd> {

  var name;
  var price;
  var brand;
  var image;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance.collection('Products').where('featured', isEqualTo: true).snapshots(),
        builder: (BuildContext context,  snapshot){
          if(!snapshot.hasData) {return Text('No data Available');}
            var product_list = [];
              snapshot.data.documents.map((document){
               product_list.add({
                  name = document['Product Name'],
                  price = document['Price'].toString(),
                  brand = document['Brand'],
                  image = document['Images'],

                  });
                }).toList();

      return GridView.builder(
      itemCount: snapshot.data.documents.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 5),
      itemBuilder: (BuildContext context, int index) {
        return singleProd(
          name: product_list[index]['name'],
          pic: product_list[index]['image'],
          price: product_list[index]['price'],
          brand: product_list[index]['brand'],
        );
      }
    );
    },
    );


//    final products = Provider.of<ProductsProvider>(context);
//
//
//    return GridView.builder(
//      itemCount: products.productsList.length,
//        scrollDirection: Axis.horizontal,
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 5),
//        itemBuilder: (BuildContext context, index){
//
//
//          return Padding(
//            padding: const EdgeInsets.all(5.0),
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(15),
//              child: Card(
////          shadowColor: const Color(0xFFF9AA33),
//                elevation: 0.0,
//                child: Hero(
//                  tag: Text('Hero'),
//                  child: Material(
//                    child: InkWell(
//                      onTap: () {
//                        Navigator.push(
//                            context, new MaterialPageRoute(
//                            builder: (BuildContext context) =>
//                                ProductDetails( // passing values of the prod to product detail page
//                                    prod_name: products.productsList[index].name,
//                                    prod_price: products.productsList[index].price.toString(),
////                                    prod_brand: brand,
//                                    prod_image: products.productsList[index].image
//                                )));
//                      },
//
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(15),
//                        child: GridTile(
//                          footer: Container(
//                            color: const Color(0xBFFFFFFF),
//                            child: Padding(
//                              padding: const EdgeInsets.all(10.0),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment
//                                    .spaceBetween,
//                                children: <Widget>[
//                                  Expanded(
//                                    child: Text(products.productsList[index].name,
//                                      style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                      ),
//                                    ),
//                                  ),
//                                  Text("Rate: " + products.productsList[index].price.toString(),
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 13.0,
//                                      color: Colors.red[900],
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//
//                          child: Image.network("${products.productsList[index].image}",
//                            fit: BoxFit.cover,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          );
//        }
//    );
  }
}


class singleProd extends StatelessWidget {
  final name;
  final pic;
  final price;
  final brand;

  singleProd({
    this.name,
    this.pic,
    this.price,
    this.brand,
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
                        prod_brand: brand,
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
                            Text("Rate: ""$price",
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
