import 'package:flutter/material.dart';

class BuildButton extends StatefulWidget {
  @override
  _BuildButtonState createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildBottomButtonText(),
        buildBottomButtonCall(),
        buildBottomButtonVideo(),
      ],
    );
  }

  void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("SORRY!!,"),
            content: new Text("we will come back very soon!"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  Widget _buildButtonText() {
    return InkWell(
      child: Container(
        child: Center(
          child: Text("Text",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
        ),
      ),
      onTap: () {
         _showDialog();
      },
    );
  }

  Widget _buildButtonCall() {
    return InkWell(
      child: Container(
        child: Center(
          child: Text("Call",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
        ),
      ),
      onTap: () {
        _showDialog();
      },
    );
  }

  Widget _buildButtonVideo() {
    return InkWell(
      child: Container(
        child: Center(
          child: Text("Video",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
        ),
      ),
      onTap: () {
        _showDialog();
      },
    );
  }

  Widget buildBottomButtonText() {
    return Container(
      height: 70.0,
      width: 120.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0, right: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFF010037),
        boxShadow: [
          new BoxShadow(
              color: Colors.black26,
              offset: new Offset(1.5, 1.5),
              blurRadius: 0.2)
        ],
      ),
      child: _buildButtonText(),
    );
  }

  Widget buildBottomButtonCall() {
    return Container(
      height: 70.0,
      width: 120.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0, right: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFF010037),
        boxShadow: [
          new BoxShadow(
              color: Colors.black26,
              offset: new Offset(1.5, 1.5),
              blurRadius: 0.2)
        ],
      ),
      child: _buildButtonCall(),
    );
  }

  Widget buildBottomButtonVideo() {
    return Container(
      height: 70.0,
      width: 120.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0, right: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFF010037),
        boxShadow: [
          new BoxShadow(
              color: Colors.black26,
              offset: new Offset(1.5, 1.5),
              blurRadius: 0.2)
        ],
      ),
      child: _buildButtonVideo(),
    );
  }
}
