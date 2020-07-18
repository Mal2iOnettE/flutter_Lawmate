import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String namePro;
  const EditProfile({Key key, this.namePro}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController titleController = TextEditingController();
  TextEditingController moredetailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String url =
        "https://firebasestorage.googleapis.com/v0/b/final-project-version-2.appspot.com/o/user%2F000057.JPG?alt=media&token=06941457-12c2-4939-9493-624af10ebd84";
    return Scaffold(
      appBar: AppBar(title: Text("Edit profile")),
      body: ListView(
        children: <Widget>[
          Container(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF010037),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                //padding: EdgeInsets.all(10.0),
                                width: 150.0, height: 150.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: DecorationImage(
                                        image: NetworkImage('$url'),
                                        fit: BoxFit.cover)),
                              ),
                              Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                              child: buildTextFieldDetail()),
                          //buildButtonSendSms()
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: buildTextEmail()),
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: buildTextFieldEmail()),
                          //buildButtonSendSms()
                        ]),
                    SizedBox(
                      height: 80.0,
                    ),
                    buildButtonSave()
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
      child: Text("Name",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Container buildTextDetail() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text("Surname",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Container buildTextEmail() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text("Email",
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
                  hintText: "Attachai",
                ),
                maxLength: 20,
                style: TextStyle(fontSize: 18)),
          ),
        ));
  }

  Container buildTextFieldDetail() {
    return Container(
        height: 50.0,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                maxLength: 50,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlign: TextAlign.left,
                decoration: InputDecoration.collapsed(hintText: ""),
                style: TextStyle(fontSize: 18)),
          ),
        ));
  }

  Container buildTextFieldEmail() {
    return Container(
        height: 50.0,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                maxLength: 50,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlign: TextAlign.left,
                decoration: InputDecoration.collapsed(hintText: ""),
                style: TextStyle(fontSize: 18)),
          ),
        ));
  }

  Future dialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Save Your profile'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Your profile has been saved'),
           
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

  Widget buildButtonSave() {
    return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Save",
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
          dialog(context);
      },
    );
  }
}
