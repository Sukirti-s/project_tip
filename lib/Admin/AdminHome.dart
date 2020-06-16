import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tip/Admin/Category_db.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tip/Admin/DeleteCategory.dart';

enum Page { dashboard, manage }

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;


  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  CategoryService _categoryService = CategoryService();


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
                  style: TextStyle(fontSize: 27.0, color: Colors.green)),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10.0,),
            Expanded(
              child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.people_outline),
                                label: Text("Customers")),
                            subtitle: Text(
                              '150',
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
                                icon: Icon(Icons.category),
                                label: Text("Categories",style: TextStyle())),
                            subtitle: Text(
                              '23',
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
                                icon: Icon(Icons.supervised_user_circle),
                                label: Text("Sellers")),
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
                                icon: Icon(Icons.change_history),
                                label: Text("Products")),
                            subtitle: Text(
                              '500',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 50.0),
                            )),
                      ),
                    ),
                  ],
              ),
            ),
          ],
        );


        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add category"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete Category"),
              onTap: () {
                Navigator.pushReplacement(
                    context, new MaterialPageRoute(
                    builder: (BuildContext context) => new DeleteCategory()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Products"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Vendors"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Customers"),
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

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value){
            if(value.isEmpty){
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(
              hintText: "add category"
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if(categoryController.text != null){
            _categoryService.createCategory(categoryController.text);
          }
          Fluttertoast.showToast(msg: 'category created');
          Navigator.pop(context);
          categoryController.clear();
          }, child: Text('ADD')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
          }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }


}