import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tip/Admin/AdminHome.dart';


class DeleteCategory extends StatefulWidget {
  @override
  _DeleteCategoryState createState() => _DeleteCategoryState();
}

class _DeleteCategoryState extends State<DeleteCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF232F34),
        centerTitle: true,
        title: Text(
          'Delete Categories',
          style: TextStyle(
            fontSize: 22.0,
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),


      body: StreamBuilder(
          stream: Firestore.instance.collection('Categories').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return Text('No data Available');

            return Container(
              color: const Color(0x1A232F34),
              child: ListView(
                children: snapshot.data.documents.map((document){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: const Color(0xFFFFFFFF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(document['Category Name'],
                              style:TextStyle(
                                color: const Color(0xFF000000),
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.delete_outline),
                              color: const Color(0xFFF9AA33),
                              onPressed: (){
                                Firestore.instance.collection('Categories').document(document['Cid']).delete();
                                Fluttertoast.showToast(msg: 'Category Deleted');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                ).toList(),

              ),
            );
          }
      ),

    );
  }
}
