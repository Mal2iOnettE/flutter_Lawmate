import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/Login/LoginByPhoneNumber.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/HomePage.dart';
import 'package:final_project_ver_2/MainMenu/More/supmenu/MyProfile/EditProfile/EditProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyProfileDetail extends StatefulWidget {
  @override
  _MyProfileDetailState createState() => _MyProfileDetailState();
}

class _MyProfileDetailState extends State<MyProfileDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  QuerySnapshot querySnapshot;
  String accountStatus = '******';
  FirebaseUser currentUser;
  String userID;
  String profileName;

  @override
  void initState() {
    //print(userID);
    getProfileList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
    super.initState();
  }

  gotoPhoneVerify() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginByPhoneNumber()));
  }

  Widget getUserID() {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          //print("userid: ${snapshot.data.uid}");
          userID = snapshot.data.uid.toString();
          return Text("user id is : $userID");
        } else {
          gotoPhoneVerify();
          return Text('Please Log in');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Detail"),
        backgroundColor: Color(0xFF010037),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfile(namePro: profileName)));
                  },
                  child: Container(
                      height: 50.0,
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 16.0),
                      )))),
        ],
      ),
      body: Column(
        children: <Widget>[
          getUserID(),
          //updateData(),
          //_buildSignOutButton(),
          _showDaysData(),
        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Center(
      child: FlatButton(
          child: Container(width: 250.0, child: Center(child: Text("Log out"))),
          color: Colors.red[500],
          onPressed: () {
            signOutDialog(context);
          }),
    );
  }

  Future<Null> signOutWithPhone() async {
    await _auth.signOut();
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (Route<dynamic> route) => false,
    );
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          //signOut(context);
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

  getProfileList() async {
    final FirebaseUser user = await _auth.currentUser();
    final userid = user.uid;
    if (user == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginByPhoneNumber()));
    } else {
      print("this is id :$userid");
      return Firestore.instance
          .collection('users')
          .where('id', isEqualTo: userid)
          .getDocuments();
    }
  }

  Widget _showDaysData() {
    return FutureBuilder(builder: (context, snapshot) {
      if (querySnapshot == null) {
        print("this is snapshot $snapshot");
        return Container(
          child: Text(
            'Your data is empty.',
            style: TextStyle(
                color: Color.fromRGBO(233, 233, 232, 1),
                fontWeight: FontWeight.w200,
                fontFamily: 'prompt',
                fontSize: 22),
          ),
        );
      } else if (querySnapshot != null) {
        return Container(
          height: 500,
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 500.0, // image height
                  child: ListView.builder(
                      //physics: AlwaysScrollableScrollPhysics(),
                      //itemExtent: 60.0, //image width
                      itemCount: querySnapshot.documents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var profileData = querySnapshot.documents;
                        //List<dynamic> exp = widget.expLawyer;
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                      'https://via.placeholder.com/250}'),
                                ),
                              ),
                              Text('${profileData[index].data['nameProfile']}',
                                  overflow: TextOverflow.ellipsis, maxLines: 5),
                              Text('${profileData[index].data['nameProfile']}'),
                              SizedBox(height: 20.0),
                              _buildSignOutButton(),
                              //profileName =  profileData[index].data['nameProfile']
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
