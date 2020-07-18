import 'package:final_project_ver_2/MainMenu/Booking/BookingPage.dart';
import 'package:final_project_ver_2/MainMenu/Browse/BrowsePage.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/AllHomePage.dart';
import 'package:final_project_ver_2/MainMenu/More/MorePage.dart';
import 'package:final_project_ver_2/SplashScreen/IntroPages/IntroPages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences prefs;
  final String lawyerID;
  final String curUserID;
  HomePage({this.prefs, this.lawyerID, this.curUserID});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  int currentIndex = 0;
  String phoneNo = "";

  getUid() {}

  @override
  void initState() {
    _auth.currentUser().then((val) {
      setState(() {
        phoneNo = val.phoneNumber;
      });
    });
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LAWMATE"),
      ),
      body: _widgetOptions.elementAt(currentIndex),
      bottomNavigationBar: _bottomNormal(),
    );
  }
  List<Widget> _widgetOptions = <Widget>[
    ////HomePage
    AllinHomePage(),
    ////Browse
    BrowsePage(),
    ///Booking
    BookingPage(),
    ///More
    MorePage(),
  ];
  Widget _bottomNormal() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_browser),
            title: Text('Browse'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Booking'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text('More'),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFF010037),
        onTap: onTabTapped,
      );
}
