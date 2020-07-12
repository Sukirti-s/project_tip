import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tip/classes/UserManagement.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String _email;
  String _password;
  String _name;
  String _role;
  final _formKey = GlobalKey<FormState>();
  final List<String> role = ['Customer', 'Vendor'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,

        //============background image==============
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/background_1.jpg'),
            fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[

            //============background gradient===========
              Container(
                decoration: BoxDecoration(
//                  gradient: LinearGradient(colors: [const Color(0xB3232F34), const Color(0xB3FFFFFF)],
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  stops: [0.3, 1.0],
//                ),
                color: const Color(0xB3232F34),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                  //===========logo===========
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                    width: 250,
                    child: Image.asset('assets/logo1.png'),
                  ),

                  //===========input box===========
                  SizedBox(height: 150.0,),
                      Container(
                        width: 300,
                          decoration: BoxDecoration(
                            color: const Color(0x99FFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[

                              //=============name============
                              SizedBox(height: 10.0,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0, right: 10.0),
                                      child: Icon(Icons.person,
                                        color: const Color(0xFF344955),
                                        size: 20.0,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: TextFormField(
                                        controller: _nameController,

                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Enter Name';
                                          };
                                          if (val.length <= 2) {
                                            return 'Name should be more than 2 chars';
                                          }
                                        },
                                        onChanged: (val) {
                                          setState(() => _name=val );
                                        } ,
                                        decoration: InputDecoration(
                                          hintText: 'Name',
                                          errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                                        ),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),

                              //===========email id============
                              SizedBox(height: 10.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0, right: 10.0),
                                    child: Icon(Icons.email,
                                      color: const Color(0xFF344955),
                                      size: 20.0,
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,

                                      validator: (val){
                                        if(val.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(val))
                                            return 'Please enter valid email address';
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() => _email=val );
                                      } ,
                                      decoration: InputDecoration(
                                        hintText: 'Email Id',
                                        errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              //============password===========
                              SizedBox(height: 10.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0, right: 10.0),
                                    child: Icon(Icons.lock_open,
                                      color: const Color(0xFF344955),
                                      size: 20.0,
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    child: TextFormField(
                                      controller: _passwordController,

                                      validator: (val){
                                        if (val.isEmpty ) {
                                          return 'Please Enter Password';
                                        };
                                        if (val.length < 6 ) {
                                          return 'Password should be more than 6 chars';
                                        };
                                      },
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() => _password=val );
                                      } ,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              //============user type drop down=============
                              SizedBox(height: 10.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0, right: 10.0),
                                    child: Icon(Icons.supervisor_account,
                                      color: const Color(0xFF344955),
                                      size: 20.0,
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Select User type',
                                        errorStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
                                      ),
                                      value: _role,
                                      items: role.map((roles){
                                        return DropdownMenuItem(
                                          value: roles,
                                          child: Text('$roles',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: const Color(0xFF000000),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      validator: (val) => val == null ? 'Please select user type' : null,
                                      onChanged: (val) {setState(() => _role = val );},
                                    ),
                                  )
                                ],
                              ),


                              //==========register button===========
                              SizedBox(height: 20.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                Container(
                                  width: 125,
                                  height: 50,
                                  child: MaterialButton(
                                    onPressed: register,
                                    elevation: 0.0,
                                    color: const Color(0xFF232F34),
                                    textColor: const Color(0xFFF9AA33),
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                    child: Text('REGISTER',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                ],
                              ),


                              //=============login link=============
                              SizedBox(height: 30.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Container(
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Already a member? ',
                                            style: TextStyle(fontSize: 16,
                                              color: Colors.black,

                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Login',
                                                  style: TextStyle(
                                                    decoration: TextDecoration.underline,
                                                    color: const Color(0xFF730006),
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0,),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }


//  =============Firebase authentication and Firestore==============

  Future<void> register() async{
    FormState formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
        try{
          FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)).user;

          Firestore.instance.collection('Users').document(user.uid).setData(
              {
                'Uid': user.uid,
                'Email Id': _emailController.text,
                'Name': _nameController.text,
                'Role': _role,
              });
          UserManagement().authorizeAccess(context);
        }catch(e){
          Fluttertoast.showToast(msg: 'Please enter correct email Id.');
        }
      }
    }
}

//validator: (val)=> val.isEmpty ?
//'Enter an email id' : null,
//onChanged: (val) {
//setState(() => _email=val );
//},

