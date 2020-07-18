import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/CaseDetail.dart';
import 'package:flutter/material.dart';

class ShowCriminalLaw extends StatefulWidget {
  final String caseTitle;
  final String caseDes;
  final String casePic;
  final dynamic code;
  ShowCriminalLaw({Key key, this.caseTitle, this.caseDes, this.casePic,this.code})
      : super(key: key);
  @override
  _ShowCriminalLawState createState() => _ShowCriminalLawState();
}

class _ShowCriminalLawState extends State<ShowCriminalLaw> {
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;
  @override
  void initState() {
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
        height: 800.0,
        child: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Divider(),
            _showCriminalLawData(),
          ],
        ));
  }

  Widget _showCriminalLawData() {
    return FutureBuilder(builder: (context, snapshot) {
      if (querySnapshot == null) {
        return Center(
          heightFactor: 2.0,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 48.0,
                    width: 48.0,
                    child: CircularProgressIndicator()),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'We are getting your data!! Wait a moment',
                  style: TextStyle(
                      //color: Color.fromRGBO(233, 233, 232, 1),
                      color: Color(0xFF010037),
                      fontWeight: FontWeight.w200,
                      fontFamily: 'prompt',
                      fontSize: 22),
                ),
              ],
            ),
          ),
        );
      } else if (querySnapshot != null) {
        return Container(
          height: 545.0,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            itemCount: querySnapshot.documents.length,
            itemBuilder: (BuildContext context, int index) {
              var showCriminalDetail = querySnapshot.documents;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    ///size of Image
                    height: 150.0,
                    width: 200.0,
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
                                "${showCriminalDetail[index].data['photoUrl']}"),
                            fit: BoxFit.cover)),
                    child: GestureDetector(
                      onTap: () {
                        _getCaseDetail(
                            showCriminalDetail[index].data['title'],
                            showCriminalDetail[index].data['des'],
                            showCriminalDetail[index].data['photoUrl']);
                      },
                    ),
                  ),
                  Container(
                    ///size of textbox
                    height: 150.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${showCriminalDetail[index].data['title']}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(
                          width: 150.0,
                          child: Text(
                            '${showCriminalDetail[index].data['des']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
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
        .document('criminalLaw')
        .collection('CriminalLaw_case')
        .where('value', whereIn: widget.code)
        .getDocuments();
  }
}
