import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/HomePage.dart';
import 'package:final_project_ver_2/SplashScreen/IntroPages/IntroPages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenMain extends StatefulWidget {
  @override
  _SplashScreenMainState createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //if (getUser() == null) {
      return SplashScreen(
          seconds: 3,
          navigateAfterSeconds: IntroPages(),
          title: new Text(
            'LAWMATE',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
          ),
          image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
          backgroundColor: Color(0xFF010037),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Final Project Version02"),
          loaderColor: Color(0xFF010037));
 
  }

  getUser() async {
    FirebaseUser curUser = await _auth.currentUser();
    //print("this is user name : $user.uid")
    DocumentReference documentReference = Firestore.instance.collection("users").document("${curUser.uid}");
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        //print('name: '+datasnapshot.data['name'].toString());
        //return Text('This is users name ${datasnapshot.data['name']}');
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
          return SplashScreenMain();
      }
    });
  }
}
