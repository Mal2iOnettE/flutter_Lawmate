import 'package:final_project_ver_2/MainMenu/HomePage/HomePage.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/ContactUS.dart/ContactUS.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/MyCard/MyCard.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/MyProfile/EditProfile/EditProfile.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/MyProfile/MyProfile.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/Notification/Notification.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/Setting/Setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

   FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150.0,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: MyProfile())
              ),
        Container(
            //padding: EdgeInsets.only(top: 25.0),
            child: Notify()),
        Container(
            //padding: EdgeInsets.only(top: 25.0),
            child: MyCards()),
        Container(
            //padding: EdgeInsets.only(top: 25.0),
            child: Setting()),
        Container(
            //padding: EdgeInsets.only(top: 25.0),
            child: ContactUs()),
        _buildSignOutButton()
      ],
    );
  }

  Widget _buildSignOutButton() {
    return Center(
      child: FlatButton(
          child: Container(
              height: 80.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0)
              ),
              child: Center(
                child: Text("Log out",
                  style: TextStyle(color: Colors.red ),)
                )),
          //color: Colors.red[500],
          onPressed: () {
            signOutDialog(context);
          }),
    );
  }

  Future<Null> signOutWithPhone() async {
    await _auth.signOut();
  }

  Future<bool> signOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Are you want to Sign out ????'),
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
                         // Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
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
