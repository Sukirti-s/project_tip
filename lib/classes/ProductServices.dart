import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/classes/ProductModel.dart';

class ProductsServices{
  Firestore _firestore = Firestore.instance;

  Future<List<Product>> getProducts()async =>
      _firestore.collection('Products').getDocuments().then((result){
        List<Product> productsList = [];
        print("=== RESULT SIZE ${result.documents.length}");
        for(DocumentSnapshot item in result.documents){
          productsList.add(Product.fromSnapshot(item));
          print(" PRODUCTSss ${productsList.length}");
        }
        return productsList;
      });
}