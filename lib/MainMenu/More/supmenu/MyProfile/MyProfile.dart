import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String image = 'https://via.placeholder.com/250';
  QuerySnapshot querySnapshot;

  FirebaseAuth _auth = FirebaseAuth.instance;
  String accountStatus = '******';
  var username;
  var userPhoto;
  String url = "https://firebasestorage.googleapis.com/v0/b/final-project-version-2.appspot.com/o/user%2F000057.JPG?alt=media&token=06941457-12c2-4939-9493-624af10ebd84";
   
 
 @override
  void initState() {
    getUser().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
    super.initState();
  }

  getUser() async {
    FirebaseUser user = await _auth.currentUser();
    print("this is user name : ${user.uid}");
    DocumentReference documentReference =
        Firestore.instance.collection("users").document("${user.uid}").collection('detail').document('user_detail');
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        username = datasnapshot.data['name'];
        userPhoto = datasnapshot.data['photo'];
        //print('photo: '+userPhoto);
        //print('name: '+datasnapshot.data['name']);
      } else {
        print("No such user");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300.0,
        width: 500.0,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8.0)),
            Container(
              //padding: EdgeInsets.all(10.0),
              width: 100.0, height: 100.0,
              decoration:
                  BoxDecoration(
                    shape: BoxShape.circle, 
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage('$url'),fit: BoxFit.cover)
                    ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 25.0, bottom: 5.0),
                  width: 200.0,
                  child: Text("WellCome!!!"),
                ),
                Container(
                    padding: EdgeInsets.only(left: 25.0),
                    height: 80.0,
                    width: 200.0,
                    child: Text('Attachai' , 
                      style: TextStyle(fontSize: 25.0),)
                    //_showDaysData()
                    ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 48.0),
              child: Icon(
                Icons.more_vert,
                color: Color(0xFF888888),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getUserName() {
    return getUser();
  }

  getLawyerList() async {
    FirebaseUser user = await _auth.currentUser();
    print("get user id : ${user.uid}");
    return Firestore.instance.collection('users').document('$user').collection('detail').getDocuments();
  }

  
}
