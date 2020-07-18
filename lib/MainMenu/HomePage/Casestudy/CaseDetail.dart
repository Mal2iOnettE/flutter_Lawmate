import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CaseDetail extends StatefulWidget {
  final String caseTitle;
  final String caseDes;
  final String casePic;
  final dynamic code;

  CaseDetail({Key key, this.caseTitle, this.caseDes, this.casePic, this.code})
      : super(key: key);
  @override
  _CaseDetailState createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCasesList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.caseTitle}"),
        backgroundColor: Color(0xFF010037),
      ),
      body: ListView(
        children: <Widget>[
          _showCaseData(), 
          _showDes(),
        ],
      ),
    );
  }

  Widget _showCaseData() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("${widget.casePic}"), fit: BoxFit.cover)),
      ),
    );
  }

  Widget _showDes() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //height: 250,
        child: Text("${widget.caseDes}"),
      ),
    );
  }

  getCasesList() async {
    return await Firestore.instance.collection('CaseStudy').getDocuments();
  }
}
