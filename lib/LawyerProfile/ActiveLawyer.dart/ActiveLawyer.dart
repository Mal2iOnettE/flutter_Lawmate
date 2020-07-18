import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/LawyerProfile/ActiveLawyer.dart/buildButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActiveLawyer extends StatefulWidget {
  final String lawyerID;

  const ActiveLawyer({Key key, this.lawyerID}) : super(key: key);

  @override
  _ActiveLawyerState createState() => _ActiveLawyerState();
}

class _ActiveLawyerState extends State<ActiveLawyer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;

  String photo;
  String name;
  String surname;

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
          title: Text(""),
          backgroundColor: Color(0xFF010037),
        ),
        bottomNavigationBar: BottomAppBar(
          child: BuildButton(),
        ),
        body: Stack(
          children: <Widget>[
            // Max Size
            Container(
              color: Colors.transparent,
            ),
            //lawyerDetail(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _showLawyerData(),
            ),
          ],
        ));
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

  Widget _showLawyerData() {
    return FutureBuilder(builder: (context, snapshot) {
      if (querySnapshot == null) {
        print("this is snapshot $snapshot");
        return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF010037))),
        );
      } else if (querySnapshot != null) {
        return Container(
          //height: 300,
          child: CustomScrollView(
            //physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 900.0, // image height
                    child: ListView.builder(
                        //physics: NeverScrollableScrollPhysics(),
                        //itemExtent: 850.0, //image width
                        itemCount: querySnapshot.documents.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var lawyerData = querySnapshot.documents;
                          var imageList = lawyerData[index].data['moredetail'];
                          return Container(
                            child: Column(
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
                                              image: NetworkImage(
                                                  "${lawyerData[index].data['photo']}"),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      height: 200.0,
                                      child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "ID: ${lawyerData[index].data['id']}"),
                                              SizedBox(height: 10.0),
                                              Text(
                                                "${lawyerData[index].data['name']}",
                                                style: TextStyle(
                                                  fontSize: 25.0,
                                                ),
                                              ),
                                              Text(
                                                "${lawyerData[index].data['surname']}",
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
                                    )
                                  ],
                                ),
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Detail',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Container(
                                        width: 370.0,
                                        color: Colors.grey[100],
                                        child: Text(
                                            '${lawyerData[index].data['short_detail']}')),
                                    Text(
                                      'Experieces',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Container(
                                        //height: 350.0,
                                        width: 370.0,
                                        color: Colors.grey[100],
                                        child: Text(
                                            '${lawyerData[index].data['exp']}')),
                                    Text(
                                      'More',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Container(
                                      height: 800.0,
                                      //width: 900.0,
                                      child: Column(
                                        children: <Widget>[
                                        Column(children: <Widget>[
                                          Image.network(imageList[0])
                                        ]),
                                        SizedBox(width: 30.0),
                                        Column(
                                          children: <Widget>[
                                            Image.network(imageList[1])
                                          ],
                                        )
                                      ]),
                                    ),
                                  ],
                                ))
                              ],
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
    return Firestore.instance
        .collection('lawyers')
        .document('${widget.lawyerID}')
        .collection('detail')
        .getDocuments();
  }
}
