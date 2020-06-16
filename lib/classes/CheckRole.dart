import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/Admin/AdminHome.dart';
import 'package:project_tip/Vendor/VendorHome.dart';
import 'package:project_tip/pages/Home_Page.dart';
import 'package:project_tip/pages/login.dart';


class RoleCheck extends StatelessWidget {
const RoleCheck({Key key, this.user}) : super(key: key);
final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('Users')
            .document(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkRole(snapshot.data);
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

//  Center checkRole(DocumentSnapshot snapshot) {
//    if (snapshot.data == null) {
//      return Center(
//        child: Text('no data set in the userId document in firestore'),
//      );
//    }
//    if (snapshot.data['role'] == 'admin') {
//      return adminPage(snapshot);
//    } else {
//      return userPage(snapshot);
//    }
//  }


  checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }

    if (snapshot.data['Role'] == 'Admin') {
      return AdminHome();
    } else if (snapshot.data['Role'] == 'User') {
      return Homepage();
    } else if (snapshot.data['Role'] == 'Vendor') {
      return VendorHome();
    } else
      return Login();
  }
}