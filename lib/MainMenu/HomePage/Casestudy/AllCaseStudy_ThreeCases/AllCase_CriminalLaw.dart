import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:final_project_001/Homepage/Casestudy/ShowCivilLaw/ShowCivilLaw.dart';
///import 'package:final_project_001/Homepage/Casestudy/ShowCriminalLaw/ShowCriminalLaw.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/MultiSelect/flutter_multiselect.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/ShowCivilLaw/ShowCivilLaw.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/ShowCriminalLaw/ShowCriminalFromSearch.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/ShowCriminalLaw/ShowCriminalLaw.dart';
import 'package:flutter/material.dart';
//import 'package:final_project_001/MultiSelect/flutter_multiselect.dart';

class AllCase_CriminalLaw extends StatefulWidget {
  final String caseTitle;
  final String caseDes;
  final String casePic;
  final dynamic code;

  AllCase_CriminalLaw(
      {Key key, this.caseTitle, this.caseDes, this.casePic, this.code})
      : super(key: key);

  @override
  _AllCase_CriminalLawState createState() => _AllCase_CriminalLawState();
}

class _AllCase_CriminalLawState extends State<AllCase_CriminalLaw> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  dynamic code;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            _searchData(),
            SizedBox(
              height: 5.0,
            ),
            ShowCriminalLaw(code: code)
          ],
        ));
  }

  Widget _searchData() {
    return Container(
      child: new Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new MultiSelect(
                  autovalidate: true,
                  //initialValue: ['IN', 'US'],
                  titleText: 'What are you looking for?',
                  maxLength: 5, // optional
                  validator: (dynamic value) {
                    if (value == null) {
                      return 'Please select one or more option(s)';
                    }
                    return null;
                  },
                  errorText: 'Please select one or more option(s)',
                  dataSource: [
                    {"name": "ทรัพย์สินทางปัญญา", "code": "1201"},
                    {"name": "ยาเสพติด", "code": "1202"},
                    {"name": "ความผิดเกี่ยวกับทรัพย์", "code": "1203"},
                    {"name": "ฆ่า", "code": "1204"},
                    {"name": "ข่มขืน", "code": "1205"},
                    {"name": "ทำร้ายร่างกาย", "code": "1206"},
                    {"name": "ปลอมแปลงเอกสาร", "code": "1207"},
                    {"name": "ชิงทรัพย์", "code": "1208"},
                    {"name": "ค้ามนุษย์", "code": "1209"},
                    {"name": "บุกรุุก", "code": "1210"},
                    {"name": "ฉ้อโกง", "code": "1211"},
                    {"name": "หมิ่นประมาท", "code": "1212"},
                    {"name": "ปล้นทรัพย์", "code": "1213"},
                    {"name": "ทำให้เสียทรัพย์", "code": "1213"},
                    {"name": "ยอมความ", "code": "1214"},
                    {"name": "พรากผู้เยาว์", "code": "1215"},
                    {"name": "หน่วงเหนี่ยวกักขัง", "code": "1216"},
                    {"name": "ลักทรัพย์", "code": "1217"},
                  ],
                  textField: 'name',
                  valueField: 'code',
                  filterable: true,
                  required: true,
                  onSaved: (value) {
                    print('The value is $value');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowSearchDataCriminal(code: value)));
                  }),
            ),
            SizedBox(
              width: 10.0,
            ),
            _buildButtonSearch()
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  void _onFormSaved(dynamic code) {
    final FormState form = _formKey.currentState;
    form.save();
  }

  Widget _buildButtonSearch() {
    return Container(
      width: 150.0,
      height: 50.0,
      child: RaisedButton(
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Text('ค้นหา'),
        textColor: Colors.white,
        color: Color(0xFF010037),
        onPressed: () {
          _onFormSaved(code);
        },
      ),
    );
  }
}
