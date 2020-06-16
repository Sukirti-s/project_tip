import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {

  var Cart_products = [
    {
    "name": "Laptop",
    "pic" : "assets/laptop3.png",
    "price": 51000/DateTime.monthsPerYear,
    "quantity": 5
    },
    {
    "name": "Headphone",
    "pic" : "assets/headphone1.jpg",
    "price": 9000/DateTime.monthsPerYear,
    "quantity": 8
    },
    {
      "name": "Headphone",
      "pic" : "assets/headphone4.jpg",
      "price": 12000/DateTime.monthsPerYear,
      "quantity": 10
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Cart_products.length,
      itemBuilder: (context, index){
        return SingleCartProd(
          Cname: Cart_products[index]['name'],
          Cpic: Cart_products[index]['pic'],
          Cprice: Cart_products[index]['price'],
          Cquantity: Cart_products[index]['quantity'],
        );
      }
    );
  }
}


class SingleCartProd extends StatefulWidget {

  final Cname;
  final Cpic;
  final Cprice;
  final Cquantity;

  SingleCartProd({
    this.Cname,
    this.Cpic,
    this.Cprice,
    this.Cquantity,
  });

  @override
  _SingleCartProdState createState() => _SingleCartProdState();
}

class _SingleCartProdState extends State<SingleCartProd> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: ListTile(
          leading: Image.asset(widget.Cpic, width: 80.0, height: 80.0,),
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
            child: Text(widget.Cname),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Price:  ''${widget.Cprice}'' /month'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,top:8.0,bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text('Quantity:  ''${widget.Cquantity}'),
                  ],
                ),
              )
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.delete,
                  color: const Color(0xFFF9AA33),
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
