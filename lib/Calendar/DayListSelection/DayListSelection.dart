import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/Calendar/ConfirmBooking/ConfirmBooking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DayListSelection extends StatefulWidget {
  final DateTime selectedTime;
  final String lawyerID;
  final String userID;
  DayListSelection({
    Key key,
    this.selectedTime,
    this.userID,
    this.lawyerID,
  }) : super(key: key);

  @override
  _DayListSelectionState createState() => _DayListSelectionState();
}

class _DayListSelectionState extends State<DayListSelection> {
  QuerySnapshot querySnapshot;
  final databaseReference = Firestore.instance;
  ScrollController _scrollControler = ScrollController();

  @override
  void initState() {
    getLawyerList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
    super.initState();
  }

  var lawID;
  String userID;
  bool enable;
  var dateTime;
  String date;
  var dateformat;
  dynamic time;
  var month2;
  var dayformat2;

  @override
  Widget build(BuildContext context) {
    date = '${widget.selectedTime}';
    dateTime = DateTime.parse(date);
    dateformat = new DateFormat('EEE,d MMM y').format(dateTime);
    month2 = new DateFormat('MMMMyyyy').format(dateTime);
    dayformat2 = new DateFormat('ddMMyyyy').format(dateTime);

    return Scaffold(
        appBar: AppBar(
          title: Text('$dateformat'),
          backgroundColor: Color(0xFF010037),
        ),
        body: _showDaysData());
  }

  alert({time}) {
    lawID = '${widget.lawyerID}';
    userID= '${widget.userID}';
    Alert(
      context: context,
      type: AlertType.success,
      title: "Confirm Date&Time",
      desc: "Date: $dateformat \n Time: $time",
      buttons: [
        DialogButton(
          color: Color(0xFF010037),
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => //Navigator.canPop(context),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmBooking(
                        curUserID: '$userID',
                        lawyerID: lawID,
                        date : '$dateformat',
                        time: '$time',
                        month: '$month2',
                        dayfor: '$dayformat2',
                        ))),
          width: 250,
        )
      ],
    ).show();
  }

  Widget _showDaysData() {
    return FutureBuilder(builder: (context, snapshot) {
      if (querySnapshot == null) {
        print("this is snapshot $snapshot");
        return Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Icon(Icons.error),
              Container(
                child: Text(
                  'Sorry, \nThere is no available Time in this day.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'prompt',
                      fontSize: 22),
                ),
              ),
            ],
          ),
        );
      } else if (querySnapshot != null) {
        return Container(
          height: 800,
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 800.0, // image height
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      //itemExtent: 60.0, //image width
                      itemCount: querySnapshot.documents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var dayData = querySnapshot.documents;
                        //List<dynamic> exp = widget.expLawyer;
                        return Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Icon(Icons.access_time),
                              title: Text(
                                dayData[index].data['time'],
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                time = dayData[index].data['time'];
                                alert(time: time);
                              },
                              enabled: dayData[index].data['enable'],
                              //selected:  element['enable'],
                            ),
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

  getLawyerList() async {
    date = '${widget.selectedTime}';
    lawID = '${widget.lawyerID}';
    dateTime = DateTime.parse(date);
    var dayfor2 = new DateFormat('ddMMyyyy').format(dateTime);
    var month = new DateFormat('MMMMyyyy').format(dateTime);
    print("this is get dayfor $dayfor2");
    print("this is get month $month");

    return Firestore.instance
        .collection('lawyers')
        .document('$lawID')
        .collection('days')
        .document('$month')
        .collection('$dayfor2')
        .getDocuments();
  }

  Widget getUserID() {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          //print("userid: ${snapshot.data.uid}");
          userID = snapshot.data.uid;
          return Text("userid: ${snapshot.data.uid}");
        } else {
          return Text('Guess');
        }
      },
    );
  }

  void updateData() {
    try {
      databaseReference
          .collection('users')
          .document('$userID')
          .updateData({'nameProfile': 'Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }
}
