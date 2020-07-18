import 'package:final_project_ver_2/LawyerProfile/LawyerProfile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;
  List<dynamic> days;
  List<dynamic> exp;

  @override
  void initState() {
    super.initState();
    getLawyerList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  _getLawyerName(
    String lawyername,
    String lawyersurname,
    String lawyerpicture,
    String lawyerid,
    dynamic lawyerdetail,
    dynamic lawyerexp
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LawyerProfile(
          nameLawyer: lawyername,
          surnameLawyer: lawyersurname,
          pictureLawyer: lawyerpicture,
          idLawyer: lawyerid,
          detailLawyer: lawyerdetail,
          expLawyer: lawyerexp
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.0,
      //color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Lawyers"),
            trailing: InkWell(onTap: () {

            }, 
            child: Text("see all")),
          ),
          Container(
            height: 280.0, width: 500.0,
            //child: _showLayerData()
            child: showLawyerData(),
          ),
        ],
      ),
    );
  }

  Widget showLawyerData() {
    return FutureBuilder(builder: (context, snapshot) {
      if (querySnapshot == null) {
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
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 300.0, // image height
                  child: ListView.builder(
                      //physics: AlwaysScrollableScrollPhysics(),
                      itemExtent: 160.0, //image width
                      itemCount: querySnapshot.documents.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var lawyerData = querySnapshot.documents;
                        print(lawyerData);
                        return Container(
                          //color: Colors.blue,
                          height: 400.0,
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                      height: 215.0,
                                      width: 250.0,
                                      //margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            new BoxShadow(
                                                color: Colors.black26,
                                                offset: new Offset(1.5, 1.5),
                                                blurRadius: 0.5
                                              )
                                          ],
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${lawyerData[index].data['lawyer_photo']}",
                                                  scale: 1.0),
                                              fit: BoxFit.cover)),
                                      child: InkWell(
                                        onTap: () {
                                          _getLawyerName(
                                            lawyerData[index].data['lawyer_name'],
                                            lawyerData[index].data['lawyer_surname'],
                                            lawyerData[index].data['lawyer_photo'],
                                            lawyerData[index].data['lawyer_id'],
                                            lawyerData[index].data['lawyer_detail'],
                                            lawyerData[index].data['lawyer_exp']
                                          );
                                          print("detail: ${lawyerData[index].data['lawyer_detail']}");
                                        },
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 2.0, right: 8.0, bottom: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            lawyerData[index].data['lawyer_name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(" "),
                                        Text(
                                            lawyerData[index].data['lawyer_surname'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
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
    return await Firestore.instance.collection('lawyers').getDocuments();
  }
}
