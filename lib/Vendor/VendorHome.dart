import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tip/Vendor/AddProduct.dart';

enum Page { dashboard, manage }

class VendorHome extends StatefulWidget {
  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 3.0,
          backgroundColor: Colors.white,
        ),


        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: const Color(0x0D000000),
          ),
          child: loadScreen(),
        )
    );
  }

  Widget loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              subtitle: Text('Rs. 12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28.0, color: Colors.green)),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10.0,),
            Expanded(
              child: Center(
                child: ListView(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.track_changes),
                                label: Text("Producs")),
                            subtitle: Text(
                              '120',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.check_circle),
                                label: Text("Sold")),
                            subtitle: Text(
                              '13',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.shopping_cart),
                                label: Text("Pending Orders")),
                            subtitle: Text(
                              '5',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.close),
                                label: Text("Return")),
                            subtitle: Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );


        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.push(
                    context, new MaterialPageRoute(
                    builder: (_) => new AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Products list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text("Delete Products"),
              onTap: () {},
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut().then((val) {
                  Navigator.pushReplacementNamed(context, '/login');
                }).catchError((e) {
                  print(e);
                });
              },
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}