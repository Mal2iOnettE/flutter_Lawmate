import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/LawyerProfile/ActiveLawyer.dart/ActiveLawyer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  final String lawyerID;
  final String curUserID;

  const HistoryPage({Key key, this.lawyerID, this.curUserID})
      : super(key: key);
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var curUserID;
  var lawID;
  QuerySnapshot querySnapshot;
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    getLawyerList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
    super.initState();
  }

  Widget _getLawyerID(
    String lawyerid,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActiveLawyer(
          lawyerID: lawyerid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _showDaysData());
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
                  'Loading...',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'prompt',
                      fontSize: 22),
                ),
              ),
              Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      } else if (querySnapshot != null) {
        return Container(
          height: 800,
          child: CustomScrollView(
            //physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 800.0, // image height
                  child: ListView.builder(
                      //physics: AlwaysScrollableScrollPhysics(),
                      //itemExtent: 60.0, //image width
                      itemCount: querySnapshot.documents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var bookingData = querySnapshot.documents;
                        //List<dynamic> exp = widget.expLawyer;
                        return Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            //: 90.0,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Finished!',style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Icon(Icons.access_time),
                                  title: Text(
                                    '${bookingData[index].data['date']}',
                                  ),
                                  subtitle: Text(
                                    bookingData[index].data['time'],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _getLawyerID(
                                        bookingData[index].data['lawyer_id']);
                                  },
                                  enabled: true,
                                  //selected:  element['enable'],
                                ),
                              ],
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
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    lawID = '${widget.lawyerID}';
    //print('curUser ${_user.uid}');
    //print('lawID is $lawID');

    return Firestore.instance
        .collection('users')
        .document('${_user.uid}')
        .collection('history')
        .getDocuments();
  }
}
