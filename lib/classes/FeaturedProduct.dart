import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/pages/ProductDetails.dart';
import 'package:project_tip/classes/ProductModel.dart';
import 'package:project_tip/classes/ProductServices.dart';


class FeaturedProd extends StatefulWidget {
  @override
  _FeaturedProdState createState() => _FeaturedProdState();
}

class _FeaturedProdState extends State<FeaturedProd> {

  var name;
  var price;
  var brand;
  var image;

  @override
  Widget build(BuildContext context) {

//    return StreamBuilder(
//        stream: Firestore.instance.collection('Products').snapshots(),
//        builder: (context, AsyncSnapshot snapshot) {
//          if (snapshot.hasData) {
//            List product_list = [];
//            for (int i = 0; i < snapshot.data.documents.length; i++) {
//              DocumentSnapshot snap = snapshot.data.documents[i];
//              product_list.add({
//                snap.data['Product Name'],
//                snap.data['Images'],
//                snap.data['Price'].toString(),
//                snap.data['Brand'],
//              });
//            }
//          }else{return Text('No Data');}
//        }
//    );


    return StreamBuilder(
          stream: Firestore.instance.collection('Products').where('featured', isEqualTo: true).snapshots(),
          builder: (BuildContext context,  snapshot){
            if(!snapshot.hasData) {return Text('No data Available');}
            List product_list = [];
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

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context, new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductDetails( // passing values of the prod to product detail page
                                      prod_name: name,
                                      prod_price: price,
                                      prod_brand: brand,
                                      prod_image: image
                                  )));
                        },
                        child: GridTile(
                          footer: Container(
                            color: const Color(0xBFFFFFFF),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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

                          child: Image.network(image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );

              }
                );
              },
    );
    }
  }



  class singleProd extends StatelessWidget {

    final name;
    final image;
    final price;
    final brand;

    singleProd({
      this.name,
      this.image,
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
                  onTap: () {
                    Navigator.push(
                        context, new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductDetails( // passing values of the prod to product detail page
                              prod_name: name,
                              prod_price: price,
                              prod_brand: brand,
                              prod_image: image
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
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
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

                      child: Image.network(image,
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

