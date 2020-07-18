import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/CaseStudy.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Ranking/Ranking.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/recommend/Recommend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllinHomePage extends StatefulWidget {
  @override
  _AllinHomePageState createState() => _AllinHomePageState();
}

class _AllinHomePageState extends State<AllinHomePage> {

   FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: CaseStudy()
        ),
        Divider(),
        Container(
          child: Recommend()
        ),
        Divider(),
        Container(
          child: Ranking(),
        ),
         Center(
              child: Text('asdasd',
               // 'Wellcome \n$phoneNo',
                style: TextStyle(color: Colors.black),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildSignOutButton(),
            ),*/
      ],
    );
  }

  
  /*Widget _buildSignOutButton() {
    return Center(
      child: FlatButton(
          child: Container(
              height: 80.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0)
              ),
              child: Center(child: Text("Log out"))),
          color: Colors.red[500],
          onPressed: () {
            signOutDialog(context);
          }),
    );
  }*/

  Future<Null> signOutWithPhone() async {
    await _auth.signOut();
  }

  Future<bool> signOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Are you want to SignOut ????'),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('YES'),
                    onPressed: () {
                      _auth.currentUser().then((user) {
                        if (user != null) {
                          signOutWithPhone();
                          Navigator.of(context).pop();
                          /*Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));*/
                        } else {
                          signOutWithPhone();
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}