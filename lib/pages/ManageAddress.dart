import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/pages/AddAddress.dart';
import 'package:project_tip/pages/Home_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  Future<String> initUser() async {
    user = await _auth.currentUser();
    setState(() {});
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF232F34),

        title: Text(
          'Addresses',
          style: TextStyle(
            fontSize: 22.0,
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            color: const Color(0x4D344955),
              label: Text('Add Address',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                ),
              ),
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, new MaterialPageRoute(
                    builder: (BuildContext context) => new AddAddress()));
              }),
        ],
      ),

      body: StreamBuilder(
        stream: Firestore.instance.collection('Categories').where('Uid', isEqualTo: user.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData) {
              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: ListView(
                  children: snapshot.data.documents.map((document) {
                    return Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Name: '),
                                Expanded(child: Text(document['Name'])),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Address: '),
                                Expanded(child: Text(
                                  document['Address'], maxLines: 5,
                                  overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('City: '),
                                Expanded(child: Text(document['City'])),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('State: '),
                                Expanded(child: Text(document['State'])),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Pin: '),
                                Expanded(child: Text(document['Pin'])),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Phone No.: '),
                                Expanded(child: Text(document['Phone No.'])),
                              ],
                            ),
                          ],
                        )
                    );
                  }).toList(),
                ),
              );
            }else return Text('No Address Available');
    }
      ),
    );
  }
}

