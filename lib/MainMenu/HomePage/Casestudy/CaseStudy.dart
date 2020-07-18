import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/AllCaseStudies.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/CaseDetail.dart';
import 'package:flutter/material.dart';

class CaseStudy extends StatefulWidget {
  @override
  _CaseStudyState createState() => _CaseStudyState();
}

class _CaseStudyState extends State<CaseStudy> {
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLawyerList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  _getCaseDetail(String title, String description, String pic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CaseDetail(
          caseTitle: title,
          caseDes: description,
          casePic: pic,
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
            title: Text("Case Study"),
            trailing: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllCaseStudies()));
                },
                child: Text("see all")
              ),
          ),
          Container(height: 280.0, width: 500.0, child: _showCasesData())
        ],
      ),
    );
  }

  Widget _showCasesData() {
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
                      itemExtent: 220.0, //image width
                      itemCount: querySnapshot.documents.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var caseStudyDetail = querySnapshot.documents;
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
                                      width: 300.0,
                                      //margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            new BoxShadow(
                                                color: Colors.black26,
                                                offset: new Offset(1.5, 1.5),
                                                blurRadius: 0.5)
                                          ],
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${caseStudyDetail[index].data['photoUrl']}",
                                                  scale: 1.0),
                                              fit: BoxFit.cover)),
                                      child: GestureDetector(
                                        onTap: () {
                                          _getCaseDetail(
                                              caseStudyDetail[index]
                                                  .data['title'],
                                              caseStudyDetail[index]
                                                  .data['des'],
                                              caseStudyDetail[index]
                                                  .data['photoUrl']);
                                          print(caseStudyDetail[index]
                                              .data['title']);
                                          print(caseStudyDetail[index]
                                              .data['des']);
                                        },
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 2.0, right: 8.0, bottom: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        caseStudyDetail[index].data['title'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
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
    return Firestore.instance
        .collection('caseStudy')
        .document('civilLaw')
        .collection('civilLaw_case')
        .getDocuments();
  }
}
