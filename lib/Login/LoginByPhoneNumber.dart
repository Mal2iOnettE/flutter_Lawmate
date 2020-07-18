
import 'package:final_project_ver_2/MainMenu/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginByPhoneNumber extends StatefulWidget {

  final SharedPreferences prefs;
  const LoginByPhoneNumber({Key key, this.prefs}) : super(key: key);  
  @override
  _LoginByPhoneNumberState createState() => _LoginByPhoneNumberState();
}

class _LoginByPhoneNumberState extends State<LoginByPhoneNumber> {
  String phoneNo, smsCode, verificationId;
  String errorMessage = '';
  SharedPreferences prefs;

  bool isLoggedIn = false;
  

  Future<void> _verify() async {
  final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed In $verId');
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      print('verified');
    };
    final PhoneVerificationFailed verifyFailed = (AuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+66" + this.phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
}

  Future<bool> smsCodeDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        height: 250.0,
        child: AlertDialog(
          title: Text("Enter the Code sent to you"),
          content: PinCodeTextField(
              textInputType: TextInputType.number,
              length: 6,
              obsecureText: false,
              animationType: AnimationType.fade,
              shape: PinCodeFieldShape.box,
              animationDuration: Duration(milliseconds: 300),
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 35,
              onChanged: (value) {
                setState(() {
                  this.smsCode = value;
                });
              },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            Center(
              child: Container(
                width: 300.0,
                height: 50.0,
                child: RaisedButton(
                  color: Color(0xFF010037),
                  child: Text("Verify",style: TextStyle(fontSize: 20,color: Colors.white)),
                  onPressed: (){
                    FirebaseAuth.instance.currentUser().then((user) {
                      if(user != null) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed('/homepage');
                      } else {
                        Navigator.of(context).pop();
                        signIn(smsCode);
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
        
      );
    }
  );
}


  Future<void> signIn(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final FirebaseUser user =(await FirebaseAuth.instance.signInWithCredential(credential)).user;
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('name', isEqualTo: user.uid)
          .getDocuments();
          print("show uid : ${user.uid}");
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(user.uid).collection('detail').document('user_detail').setData({
          'mobile': user.phoneNumber,
          'photo': user.photoUrl,
          'id': user.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'name' : user.displayName
          //'chattingWith': null
        });
        // Update data to server if new user
        Firestore.instance.collection('mobiles').document(user.phoneNumber).setData({
          'mobile': user.phoneNumber,
          'photoUrl': user.photoUrl,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          // 'chattingWith': null
        });
        print('test user id: ${user.uid}');
          //Navigator.of(context).pushAndRemoveUntil(HomePage(), (Route<dynamic> route) => false);
        Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsCodeDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        //automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF010037),
      ),
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              //border: Border.all(width: 8.0)
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(3.0, 3.0) 
                )
              ],
              /*gradient: LinearGradient(
                  colors: [Colors.yellow[100], Colors.green[100]])*/
              color: Color(0xFF010037)
                  ),
          margin: EdgeInsets.all(32),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildText(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: build66(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: buildTextFieldPhoneNumber(),
                    ),
                  ),
                ],
              ),
              (errorMessage != ''
                  ? Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    )
                  : Container()),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    buildButtonRequestOTP(),
                    SizedBox(height: 10.0),
                    //buildButtonCancel(),
                    //Text("Cancel",style: TextStyle(color:Colors.red,fontSize: 18.0))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container build66() {
    return Container(
        height: 50.0,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), 
            color: Colors.white),
        child:
            Text("+66", style: TextStyle(fontSize: 18, color: Colors.black)));
  }

  Container buildText() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Text("Login with phone number",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Container buildTextFieldPhoneNumber() {
    return Container(
        height: 50.0,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(16)),
        child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              this.phoneNo = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
                hintText: "0123456789",
                hintStyle: TextStyle(color: Colors.black12)),
            style: TextStyle(fontSize: 18)));
  }

  Widget buildButtonRequestOTP() {
    return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Request for OTP",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.amberAccent[700],
              /*boxShadow: [
                BoxShadow(
                  color: Colors.redAccent,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(3.0, 3.0) 
                )
              ]*/
              ),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12)),
      onTap: () {
        _verify();
      },
    );
  }
}
