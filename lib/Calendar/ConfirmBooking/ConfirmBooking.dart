import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/MainMenu/Booking/BookingPage.dart';
import 'package:final_project_ver_2/MainMenu/Booking/Upcoming/Upcoming.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmBooking extends StatefulWidget {
  final String lawyerID;
  final dynamic date;
  final dynamic time;
  final String curUserID;
  final dynamic month;
  final dynamic dayfor;
  const ConfirmBooking(
      {Key key,
      this.lawyerID,
      this.date,
      this.time,
      this.curUserID,
      this.month,
      this.dayfor})
      : super(key: key);

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Succesfuly Boooking!! \n ${widget.lawyerID}")),
      body: buildBottomButton(),
    );
  }

  Widget buildBottomButton() {
    var curUserID = '${widget.curUserID}';
    var lawID = '${widget.lawyerID}';
    var active = true;
    var time = '${widget.time}';
    var date = '${widget.date}';
    var month = '${widget.month}';
    var dayfor = '${widget.dayfor}';
    //var datefor = DateTime.parse('${widget.date}');
    //dynamic dateformat = new DateFormat('EEE,d/M/y').format(datefor);

    print('date $date');

    return Center(
      child: Container(
          height: 70.0,
          width: 300.0,
          margin: EdgeInsets.all(20.0),
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
          child: InkWell(
            onTap: () async {
              print('Lawyer ID: $lawID');

              ///create new activities in 'users'
              Firestore.instance
                  .collection('users')
                  .document('$curUserID')
                  .collection('upcoming')
                  .document('$lawID')
                  .setData({
                'lawyer_id': '$lawID',
                'active': '$active',
                'date': '$date',
                'time': '$time',
                'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
              });

              //update 'lawyers/days'
              Firestore.instance
                  .collection('lawyers')
                  .document('$lawID')
                  .collection('days')
                  .document('$month')
                  .collection('$dayfor')
                  .document('$time')
                  .updateData({'enable': false});

              Navigator.pushReplacementNamed(context, '/homepage');
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UpcomingPage(
                            lawyerID: lawID, 
                            curUserID: curUserID))
                          );*/
            },
            child: Container(
              child: Center(
                child: Text("Done",
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            ),
          )),
    );
  }
}
