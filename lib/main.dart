import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_tip/Admin/AdminHome.dart';
import 'package:project_tip/Vendor/VendorHome.dart';


//page imports
import 'package:project_tip/pages/login.dart';
import 'package:project_tip/pages/Home_Page.dart';
import 'package:project_tip/pages/register.dart';
import 'package:project_tip/pages/ProductDetails.dart';
import 'package:project_tip/classes/UserManagement.dart';

void main() => runApp(MyApp());

final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/homepage': (context) => Homepage(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/productDetails': (context) => ProductDetails(),
      },

      home:
//      UserManagement().handleAuth(),
//        Homepage()
        Login()
//        VendorHome()
//        AdminHome()
    );
  }
}



//firebase_auth: ^0.14.0+5
//cloud_firestore: ^0.12.9+4
