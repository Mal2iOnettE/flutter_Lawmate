import 'package:final_project_ver_2/MainMenu/Booking/History/History.dart';
import 'package:final_project_ver_2/MainMenu/Booking/Upcoming/Upcoming.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final String lawyerID;
  final String curUserID;
  const BookingPage({Key key, this.lawyerID, this.curUserID}) : super(key: key);
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  var lawID;
  var curUserID;
  @override
  Widget build(BuildContext context) {
    lawID = '${widget.lawyerID}';
    curUserID = '${widget.curUserID}';
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: TabBar(
                indicatorColor: Color(0xFF010037),
                labelColor: Color(0xFF010037),
                unselectedLabelColor: Color(0xFF666666),
                tabs: [
                  Tab(
                    icon: Icon(Icons.timer),
                    child: Text("Upcoming"),
                  ),
                  Tab(
                    icon: Icon(Icons.history),
                    child: Text("History"),
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(20.0)),
        ),
        extendBodyBehindAppBar: true,
        body: TabBarView(
          children: [
            UpcomingPage(),
            HistoryPage()
          ],
        ),
      ),
    );
  }
}
