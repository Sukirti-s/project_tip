import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/Admin/AdminHome.dart';
import 'package:project_tip/Vendor/VendorHome.dart';
import 'package:project_tip/pages/Home_Page.dart';
import 'package:project_tip/pages/login.dart';
import 'dart:async';

class UserManagement {


  Widget handleAuth() {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return authorizeAccess(context);
          }else {
          return Login();
        }
      }
    );
  }



// ===============Role based login=================

  authorizeAccess(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('Users')
          .where('Uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['Role'] == 'Vendor') {
            Navigator.pushReplacement(
                context, new MaterialPageRoute(
                    builder: (BuildContext context) => new VendorHome()));
          } else if(docs.documents[0].data['Role'] == 'Customer'){
            Navigator.pushReplacement(
                context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Homepage()));
          }else if(docs.documents[0].data['Role'] == 'Admin'){
            Navigator.pushReplacement(
                context, new MaterialPageRoute(
                builder: (BuildContext context) => new AdminHome()));
        }
      }}
      );
    });
  }
}