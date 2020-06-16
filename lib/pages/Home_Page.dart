import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:project_tip/classes/Cart_Products.dart';
import 'package:project_tip/classes/FeaturedProduct.dart';
import 'package:project_tip/classes/Product_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/pages/Categories.dart';
import 'package:project_tip/pages/Shopping_cart.dart';
import 'package:provider/provider.dart';


class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

@override
  Widget build(BuildContext context) {


    Widget image_carousal = Container(
      height: 220.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/camera1.jpg'),
          AssetImage('assets/speaker1.jpg'),
          AssetImage('assets/headphone2.png'),
          AssetImage('assets/laptop2.jpg'),
          AssetImage('assets/headphone4.jpg'),
          AssetImage('assets/camera3.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.ease,
        autoplayDuration: Duration(seconds: 5),
        borderRadius: true,
        dotSize: 4.0,
        indicatorBgPadding: 5.0,
        dotBgColor: const Color(0x00232F34),
        dotColor: const Color(0x99F9AA33),
        dotIncreasedColor: const Color(0x99F9AA33),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF232F34),
        centerTitle: true,
        title: Text(
          'ElectroKart',
          style: TextStyle(
            fontSize: 22.0,
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              }),
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

      //============Drawer=============
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            //=============drawer header=============
            UserAccountsDrawerHeader(
              accountName: Text('Sukirti'),
              accountEmail: Text('sukirti1998@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: Image.asset('assets/human.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: const Color(0xFF232F34),
              ),
            ),

            //============drawer body============
            ListTile(
              title: Text('Home', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.home, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){},
            ),


            ListTile(
              title: Text('Profile', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.person, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){},
            ),

            ListTile(
              title: Text('Categories', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.category, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){
                Navigator.push(
                    context, new MaterialPageRoute(
                    builder: (BuildContext context) => new DisplayCategory()));
              },
            ),

            ListTile(
              title: Text('Favourites', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.favorite, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){},
            ),

            ListTile(
              title: Text('Shopping Cart', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.shopping_cart, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){
                Navigator.push(
                    context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Cart()));
              },
            ),

            ListTile(
              title: Text('My Orders', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.shopping_basket, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){},
            ),

            Divider(),
            ListTile(
              title: Text('Settings', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.settings, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){},
            ),

            ListTile(
              title: Text('About', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.help, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){},
            ),

            Divider(),
            ListTile(
              title: Text('Logout', style: TextStyle(fontSize: 17.0)),
              leading: Icon(Icons.exit_to_app, color: const Color(0xFFF9AA33), size: 25.0,),
              onTap: (){
                FirebaseAuth.instance.signOut().then((val) {
                  Navigator.pushReplacementNamed(context, '/login');
                }).catchError((e) {
                  print(e);
                });
              },
            ),
          ],
        ),
      ),



      // ============homepage body============

      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
//        decoration: BoxDecoration(
//          color: const Color(0x0D000000),
//        ),

          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: image_carousal,
                  onTap: (){},
                ),
              ),


//              =============Categories=============
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10.0),
                      child: Text('Top Categories',
                        style: TextStyle(
                          color: const Color(0xFF000000),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              //===========Categories button==============
              Container(
                height: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icon_camera1.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text('Cameras'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icon_headphone.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text('HeadPhones'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icon_laptop.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text('Laptops'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/icon_phone.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text('Phones'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              //============Categories page button=============
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        onTap: (){},
                        child: Text('View all',
                          style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              //==============Featured Products==============
              SizedBox(height: 10.0,),
              Divider(color: const Color(0xB3344955),indent: 10.0,endIndent: 10.0,),
              Container(
                child: Padding(padding: EdgeInsets.all(10.0),
                  child: Text('Featured Products',
                    style: TextStyle(
                      color: const Color(0xFF000000),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),



              //=============Featured Products=============
              Padding(
                padding: const EdgeInsets.all(8.0),
                 child: Container(
                  height: 200,
                  child: Products(),
                ),
              ),


              SizedBox(height: 10.0,),
              Divider(color: const Color(0xB3344955),indent: 10.0,endIndent: 10.0,),
              Container(
                child: Padding(padding: EdgeInsets.all(10.0),
                  child: Text('Top Deals',
                    style: TextStyle(
                      color: const Color(0xFF000000),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),


//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Container(
//                  height: 250,
//                  child: CartProducts(),
//                ),
//              ),
//
//              SizedBox(height: 100.0,)
            ],
          ),
        ),
      ),
    );
  }

}


class DataSearch extends SearchDelegate<String>{

  final nosugg = ['Camera'];
  final products = ['Camera Lenses','Laptops','Desktop','Camera'] ;

  @override
  List<Widget> buildActions(BuildContext context) {
   // actions for app bar
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          size: 25.0,
        ),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left
    return
    IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        size: 25.0,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show result based on suggestion selection
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show search suggestions
    final suggestionList = query.isEmpty? nosugg: products.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context,index) => ListTile(
      leading: Icon(Icons.widgets, size: 15.0,),
      title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,
    );
  }

}


//Divider(),

//const Color(0xFF232F34)
//const Color(0xFFF9AA33)





