import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class CategoryService{

  void createCategory(String Cname){

    DocumentReference docRef = Firestore.instance.collection('Categories').document();
    docRef.setData(
        {
          'Category Name': Cname,
          'Cid': docRef.documentID,
        });
  }

}


