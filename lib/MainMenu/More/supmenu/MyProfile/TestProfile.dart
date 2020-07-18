import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  QuerySnapshot querySnapshot;
  String image = 'https://via.placeholder.com/250';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page UI Design using Flutter ",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      //backgroundColor: Colors.blue[300],
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SourceSansPro',
                  color: Colors.red[400],
                  letterSpacing: 2.5,
                ),
              ),
              Text(
                'Proto Coders Point',
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Container(
                height: 50.0,
                width: 150.0,
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    color: Colors.yellow[50],
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                    //keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                     autofocus: true,
                    decoration: InputDecoration.collapsed(
                      //border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "1234567890",
                        hintStyle: TextStyle(color: Colors.black12)),
                    style: TextStyle(fontSize: 18)),
              ),
              /*Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(
                          hintText: "name",
                          hintStyle: TextStyle(color: Colors.black12)),
                      style: TextStyle(fontSize: 18))),*/
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.cake,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    '08-05-1995',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  
}
