import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tip/pages/ManageAddress.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  final _addressFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF232F34),
        centerTitle: true,
        title: Text(
          'Add Address',
          style: TextStyle(
            fontSize: 20.0,
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Form(
        key: _addressFormKey,

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


              //===========Customer Name==========

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,

                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Name';
                    };
                    if (val.length <= 2) {
                      return 'Name should be more than 2 chars';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                  ),
                ),
              ),


              //===========Address==========

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.multiline,

                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Address';
                    };
                    if (val.length <= 15) {
                      return 'Address should be more than 15 chars';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Address',
                    errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                  ),
                ),
              ),


              //===========City==========

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: cityController,
                  keyboardType: TextInputType.text,

                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter City';
                    };
                    if (val.length <= 2) {
                      return 'City should be more than 2 chars';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'City',
                    errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                  ),
                ),
              ),


              //===========State==========

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: stateController,

                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter State';
                    };
                    if (val.length <= 2) {
                      return 'State should be more than 2 chars';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'State',
                    errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                  ),
                ),
              ),


              //===========Pin==========

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: pinController,
                  keyboardType: TextInputType.number,

                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Pin';
                    };
                    if (val.length < 6) {
                      return 'Phone number should contain 6 digits';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Pin',
                    errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                  ),
                ),
              ),



              //===========Phone No.==========

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,

                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Phone number';
                    };
                    if (val.length < 10) {
                      return 'Phone number should contain 10 digits';
                    }
                  },

                  decoration: InputDecoration(
                    hintText: 'Phone No.',
                    errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                  ),
                ),
              ),


              //============Add button============

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: MaterialButton(
                  onPressed: addressAdd,
                  elevation: 0.0,
                  color: const Color(0xFF232F34),
                  textColor: const Color(0xFFF9AA33),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Add Address',
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

  void addressAdd() async{
    FormState formState = _addressFormKey.currentState;
    if(formState.validate()){
      setState(() => isLoading = true);
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.currentUser());
        DocumentReference docRef = Firestore.instance.collection('Address').document();
        docRef.setData({
          'Uid': user.uid,
          'Aid': docRef.documentID,
          'Name': nameController.text,
          'Address': addressController.text,
          'City': cityController.text,
          'State': stateController.text,
          'Pin': int.parse(pinController.text),
          'Phone No.': int.parse(phoneController.text)
        });
        setState(() => isLoading = false);
        _addressFormKey.currentState.reset();
        Fluttertoast.showToast(msg: 'Address Added');
        Navigator.pushReplacement(
        context, new MaterialPageRoute(
        builder: (BuildContext context) => new ManageAddress()));
      }catch(e){
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Error adding address');
        print(e.message);
      }
    }
  }
}
