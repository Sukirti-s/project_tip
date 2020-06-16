import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final _productFormKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var selectedCategory;

  bool onSale = false;
  bool featured = false;

  File image1;
//  File image2;
//  File image3;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF232F34),
        centerTitle: true,
        title: Text(
          'Add Product',
          style: TextStyle(
            fontSize: 22.0,
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Form(
        key: _productFormKey,

        child: isLoading ? Center(child: CircularProgressIndicator()):
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                color: const Color(0x0D000000),
                ),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 5.0,),

                    //=========image picker==========
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: OutlineButton(
                            onPressed: (){
                              _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                            },
                            borderSide: BorderSide(color: const Color(0x40000000), width: 2.0),
                            child: _displayImg1(),
                          ),
                        ),
                      ],
                    ),


                    //===========product name==========

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: productNameController,

                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Product Name';
                          };
                          if (val.length <= 2) {
                            return 'Product Name should be more than 2 chars';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Name',
                          errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                        ),
                      ),
                    ),


                    //===========brand name==========

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: brandNameController,

                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Brand Name';
                          };
                          if (val.length <= 2) {
                            return 'Product Name should be more than 2 chars';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Brand Name',
                          errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                        ),
                      ),
                    ),


                    //===========Price==========

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,

                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Price';
                          };
                        },
                        decoration: InputDecoration(
                          hintText: 'Price',
                          errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                        ),
                      ),
                    ),


                    //===========Categories==========


                    StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('Categories').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          List<DropdownMenuItem> categoryItems= [];
                          for(int i=0; i<snapshot.data.documents.length; i++){
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            categoryItems.add(
                              DropdownMenuItem(
                                child: Text(snap.data['Category Name']),
                                value: '${snap.data['Category Name']}',
                              )
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: 'Select Category',
                                errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                              ),
                              items: categoryItems,
                                validator: (val) => val == null ? 'Please select Category' : null,
                                onChanged: (categoryItems) {setState(() => selectedCategory = categoryItems );},
                              value: selectedCategory,
                              ),
                            );
                        }else{
                          return Text('error');
                        }
                      },
                    ),



                    //===========Quantity==========

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller:quantityController,
                        keyboardType: TextInputType.number,

                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Quantity';
                          };
                        },
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                          errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                        ),
                      ),
                    ),



                    //===========Product Description============

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: descriptionController,

                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter product description';
                          };
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Description',
                          errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                        ),
                      ),
                    ),


                    //============options=============

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('On Sale'),
                            SizedBox(width: 10,),
                            Switch(value: onSale, onChanged: (value){
                              setState(() {
                                onSale = value;
                              });
                            }),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Text('Featured'),
                            SizedBox(width: 10,),
                            Switch(value: featured, onChanged: (value){
                              setState(() {
                                featured = value;
                              });
                            }),
                          ],
                        ),

                      ],
                    ),



                    //============Add button============

                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: MaterialButton(
                        onPressed: prodAdd,
                        elevation: 0.0,
                        color: const Color(0xFF232F34),
                        textColor: const Color(0xFFF9AA33),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Add Product',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
        ),
      ),
    );
  }


  //=========== On Button press ============

  void prodAdd() async{
    FormState formState = _productFormKey.currentState;
    if (formState.validate()) {
      setState(() => isLoading = true);
      formState.save();
      try {
        String ImgUrl1;
//        String ImgUrl2;
//        String ImgUrl3 ;

        FirebaseUser user = (await FirebaseAuth.instance.currentUser());
        final FirebaseStorage storage = FirebaseStorage.instance;

        final String picture1 = "Product images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 = storage.ref().child(picture1).putFile(image1);
//
//        final String picture2 = "Product images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//        StorageUploadTask task2 = storage.ref().child(picture2).putFile(image2);
//
//        final String picture3 = "Product images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//        StorageUploadTask task3 = storage.ref().child(picture3).putFile(image3);

//        StorageTaskSnapshot snapshot1 = await task1.onComplete.then((snapshot) => snapshot);
//        StorageTaskSnapshot snapshot2 = await task2.onComplete.then((snapshot) => snapshot);

        task1.onComplete.then((snapshot1) async{
          ImgUrl1 = await snapshot1.ref.getDownloadURL();
//          ImgUrl2 = await snapshot2.ref.getDownloadURL();
//          ImgUrl3 = await snapshot3.ref.getDownloadURL();
          List<String> imgList = [ImgUrl1,
//            ImgUrl2, ImgUrl3
          ];


          DocumentReference docRef = Firestore.instance.collection('Products').document();
          docRef.setData({
            'Product Name': productNameController.text,
            'Pid': docRef.documentID,
            'Brand': brandNameController.text,
            'Price': int.parse(priceController.text),
            'Quantity': int.parse(quantityController.text),
            'Product Description': descriptionController.text,
            'Uid': user.uid,
            'Images': imgList,
            'sale':onSale,
            'featured':featured,
            'Category': Firestore.instance
              .collection('Categories')
              .document(selectedCategory).documentID

            //          'Category': Firestore.instance
//              .collection('Categories')
//              .where('Category Name', isEqualTo: selectedCategory)
//              .getDocuments().then((querySnapshot){
//                querySnapshot.documents.forEach((element) {
//                  return element.data['Cid'];
//                });
//              }),

//            'Category': Firestore.instance
//                .collection('Categories')
//                .document('Cid')
          });
          setState(() => isLoading = false);
          _productFormKey.currentState.reset();
          Fluttertoast.showToast(msg: 'Product Added');
          Navigator.pop(context);
        });

      }catch(e){
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: e);
        print(e.message);
      }
    }
  }



  //============image picker=============

  void _selectImage(Future<File> pickImage, int imageNum) async{
    File tempImg = await pickImage;
    switch(imageNum){
      case 1: setState(() => image1 = tempImg);
      break;
//      case 2: setState(() => image2 = tempImg);
//      break;
//      case 3: setState(() => image3 = tempImg);
//      break;
    }
  }


  //=============image displayer==============

  Widget _displayImg1() {
    if (image1 == null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(Icons.add),
      );
    } else {
       return Image.file(image1, fit: BoxFit.fill, width: 100);
    }
  }


//    Widget _displayImg2() {
//      if (image2 == null) {
//        return Padding(
//          padding: const EdgeInsets.all(20.0),
//          child: Icon(Icons.add),
//        );
//      } else {
//          return Image.file(image2, fit: BoxFit.fill,width: double.infinity);
//      }
//    }
//
//
//    Widget _displayImg3() {
//      if (image3 == null) {
//        return Padding(
//          padding: const EdgeInsets.all(20.0),
//          child: Icon(Icons.add),
//        );
//      } else {
//         return Image.file(image3, fit: BoxFit.fill, width: double.infinity,);
//      }
//    }

  }