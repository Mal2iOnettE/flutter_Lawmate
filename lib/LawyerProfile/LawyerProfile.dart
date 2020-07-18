import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/Calendar/DayListSelection/DayListSelection.dart';
import 'package:final_project_ver_2/Calendar/flutter_rounded_date_picker_hijacked/rounded_picker.dart';
import 'package:final_project_ver_2/Login/LoginByPhoneNumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class LawyerProfile extends StatefulWidget {
  final String nameLawyer;
  final String surnameLawyer;
  final String pictureLawyer;
  final String userID;
  final dynamic idLawyer;
  final dynamic detailLawyer;
  final dynamic expLawyer;

  LawyerProfile({
    Key key,
    this.nameLawyer,
    this.surnameLawyer,
    this.pictureLawyer,
    this.userID,
    this.idLawyer,
    this.detailLawyer,
    this.expLawyer,
    // this.daysLawyer,
    // this.expLawyer
  }) : super(key: key);
  @override
  _LawyerProfileState createState() => _LawyerProfileState();
}

class _LawyerProfileState extends State<LawyerProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;

  List<dynamic> day;
  List<dynamic> exp;
  DateTime dateTime;
  Duration duration;
  DateTime newDateTime;
  dynamic lawyer_detail;

  Future getCerrentUser(DateTime newDateTime, String lawID) async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    print('User: ${_user.uid ?? "None"}');
    if (_user != null) {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DayListSelection(
                  selectedTime: newDateTime,
                  lawyerID: lawID,
                  userID: _user.uid)));
    } else {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginByPhoneNumber()));
    }
  }

  @override
  void initState() {
    getLawyerList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text("MRT Go Around"),
          title: Text("${widget.nameLawyer}\t${widget.surnameLawyer}"),
          backgroundColor: Color(0xFF010037),
        ),
        bottomNavigationBar: BottomAppBar(
            //color: Colors.blue,
            child: buildBottomButton()),
        body: Stack(
          children: <Widget>[
            // Max Size
            Container(
              color: Colors.transparent,
            ),
            //lawyerDetail(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildHeaderProfile(),
            ),
          ],
        )
      );
  }

  Widget lawyerDetail() {
    return Container(
      //alignment: Alignment.center,
      //color: Colors.amber[200],
      height: 200.0,
      //width: 0.0,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("ID: ${widget.idLawyer}"),
              SizedBox(height: 10.0),
              Text(
                "${widget.nameLawyer}",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              Text(
                "${widget.surnameLawyer}",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              stars(),
              FlatButton(
                child: Text("review"),
                onPressed: () {},
              )
            ],
          )),
    );
  }

  Widget stars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.amber[500]),
        Icon(Icons.star, color: Colors.amber[500]),
        Icon(Icons.star, color: Colors.amber[500]),
        Icon(Icons.star, color: Colors.amber[500]),
        Icon(Icons.star_half, color: Colors.amber[500]),
        Text(
          "4.5",
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget _buildHeaderProfile() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  height: 250.0,
                  width: 180.0,
                  //margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black26,
                            offset: new Offset(1.5, 1.5),
                            blurRadius: 0.5)
                      ],
                      image: DecorationImage(
                          image: NetworkImage("${widget.pictureLawyer}"),
                          fit: BoxFit.cover)),
                ),
                lawyerDetail(),
              ],
            ),
            detail(),
          ],
        ),
      ],
    );
  }

  Widget detail() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Detail',
          style: TextStyle(fontSize: 20.0),
        ),
        Container(
            width: 370.0,
            //height: 250.0,
            color: Colors.grey[100],
            child: Text('${widget.detailLawyer}')),
        Text(
          'Experieces',
          style: TextStyle(fontSize: 20.0),
        ),
        Container(
            //height: 350.0,
            width: 370.0,
            color: Colors.grey[100],
            child: Text('${widget.expLawyer}')),
        Text(
          'More',
          style: TextStyle(fontSize: 20.0),
        ),
        Container(
            //height: 350.0,
            width: 370.0,
            color: Colors.grey[100],
            child: _showExpData()),
      ],
    ));
  }

  Widget _buildButtonBooking() {
    var lawID = '${widget.idLawyer}';
    return InkWell(
      child: Container(
        child: Center(
          child: Text("Booking",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
        ),
      ),
      onTap: () async {
        newDateTime = await showRoundedDatePicker(
          context: context,
          locale: Locale('th', 'TH'),
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1),
          borderRadius: 5,
        );
        if (newDateTime != null) {
          setState(
            () => dateTime = newDateTime,
          );
          print(newDateTime);
          return getCerrentUser(newDateTime, lawID);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DayListSelection(
                        selectedTime: newDateTime,
                        lawyerID: lawID,
                      )));
        }
        //getCerrentUser('${widget.userID}');
        //checkAuth(context, '${widget.userID}');
        //_checkedIfLoggedIn02();
        /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => DayListSelection()));*/
      },
    );
  }

  Widget buildBottomButton() {
    //print('check lawyer $checkLawyer');
    return Container(
        height: 70.0,
        width: 50.0,
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
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
        child: _buildButtonBooking());
  }

  Widget _showExpData() {
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
          height: 300,
          child: CustomScrollView(
            //physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 300.0, // image height
                    child: ListView.builder(
                        //physics: NeverScrollableScrollPhysics(),
                        itemExtent: 850.0, //image width
                        itemCount: querySnapshot.documents.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var lawyerData = querySnapshot.documents;
                          print('photo: "${lawyerData[index].data['photo']}"');

                          var imageList = lawyerData[index].data['photo'];
                          return Container(
                            height: 215.0,
                            width: 500.0,
                            //margin: EdgeInsets.all(5.0),
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[ Image.network(imageList[0])]
                                  ),
                                  SizedBox(width:15.0),
                                  Row(
                                    children: <Widget>[ Image.network(imageList[1])],
                                  )
                                
                              ]),
                            ),
                          );
                        })),
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

  getLawyerList() async {
    var document = '${widget.idLawyer}';
    return Firestore.instance
        .collection('lawyers')
        .document(document)
        .collection('moredetail')
        .getDocuments();
  }
}
