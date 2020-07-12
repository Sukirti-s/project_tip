import 'package:flutter/material.dart';
import 'package:project_tip/classes/ProductModel.dart';
import 'package:project_tip/classes/ProductServices.dart';


class ProductsProvider with ChangeNotifier{
  List<Product> productsList = [];
  ProductsServices _productsServices = ProductsServices();

  ProductsProvider(){
    loadProducts();
  }
  Future loadProducts()async{
    productsList = await _productsServices.getProducts();
    notifyListeners();
  }
}