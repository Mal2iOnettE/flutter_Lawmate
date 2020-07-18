import 'package:flutter/material.dart';

class ContactUsDetail extends StatefulWidget {
  @override
  _ContactUsDetailState createState() => _ContactUsDetailState();
}

class _ContactUsDetailState extends State<ContactUsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us"),
        backgroundColor:Color(0xFF010037),
      ),
      body: Card(
        child: Container(
          height: 70.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text("Setting"),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}