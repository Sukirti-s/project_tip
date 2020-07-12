import 'package:cloud_firestore/cloud_firestore.dart';

class
Product{
  static const NAME = "Product Name";
  static const PRICE = "Price";
  static const IMAGE = "Images";

  String _name;
  String _price;
  String _image;

//   getters

  String get name => _name;
  String get price => _price;
  String get image => _image;

  Product.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data[NAME];
    _price = snapshot.data[PRICE].toString();
    _image = snapshot.data[IMAGE];
  }

}