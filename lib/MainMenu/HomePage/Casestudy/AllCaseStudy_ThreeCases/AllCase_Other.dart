import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllCase_Other extends StatefulWidget {
  @override
  _AllCase_OtherState createState() => _AllCase_OtherState();
}

class _AllCase_OtherState extends State<AllCase_Other> {
  TextEditingController titleController = TextEditingController();
  TextEditingController moredetailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ListView(
        children: <Widget>[
          Container(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF010037),
                  /* gradient: LinearGradient(
                        colors: [Colors.yellow[100], Colors.green[100]])*/
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: buildTextTitle()),
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: buildTextFieldTitle()),
                          //buildButtonSendSms()
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: buildTextDetail()),
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: buildTextFieldDetail())
                          //buildButtonSendSms()
                        ]),
                    buildButtonSend()
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Container buildTextTitle() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text("Title",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Container buildTextDetail() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text("Detail",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Container buildTextFieldTitle() {
    return Container(
        height: 50.0,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration.collapsed(
                  hintText: "",
                ),
                maxLength: 20,
                style: TextStyle(fontSize: 18)),
          ),
        ));
  }

  Container buildTextFieldDetail() {
    return Container(
        height: 200.0,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                maxLength: 250,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlign: TextAlign.left,
                decoration: InputDecoration.collapsed(hintText: ""),
                style: TextStyle(fontSize: 18)),
          ),
        ));
  }

  Widget buildButtonSend() {
    return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Send",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.amber[600],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: new Offset(1.5, 1.5),
                    blurRadius: 0.5)
              ]),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());

        //verifyPhone();
      },
    );
  }
}
