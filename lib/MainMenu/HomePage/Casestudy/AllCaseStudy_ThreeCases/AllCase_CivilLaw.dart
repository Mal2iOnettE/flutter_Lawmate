import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/MultiSelect/flutter_multiselect.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/ShowCivilLaw/ShowCivilLaw.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/ShowCivilLaw/ShowDataFromSearch.dart';
import 'package:flutter/material.dart';


class AllCase_CivilLaw extends StatefulWidget {
  final String caseTitle;
  final String caseDes;
  final String casePic;
  final dynamic code;

  AllCase_CivilLaw(
      {Key key, this.caseTitle, this.caseDes, this.casePic, this.code})
      : super(key: key);

  @override
  _AllCase_CivilLawState createState() => _AllCase_CivilLawState();
}

class _AllCase_CivilLawState extends State<AllCase_CivilLaw> {
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
            ShowCivilLaw(code: code)
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
                  validator: (value) {
                    if (value == null) {
                      return 'Please select one or more option(s)';
                    }
                    return null;
                  },
                  errorText: 'Please select one or more option(s)',
                  dataSource: [
                    {"name": "ครอบครัว", "code": "1101"},
                    {"name": "ทรัพย์สินทางปัญญา", "code": "1102"},
                    {"name": "เช่าซื้อ", "code": "1103"},
                    {"name": "ที่ดิน", "code": "1104"},
                    {"name": "กู้ยืม", "code": "1105"},
                    {"name": "มรดก", "code": "1106"},
                    {"name": "แรงงาน", "code": "1107"},
                    {"name": "คุ้มครองผู้บริโภค", "code": "1108"},
                    {"name": "ประกันภัย", "code": "1109"},
                    {"name": "ผิดสัญญา", "code": "1110"},
                    {"name": "การค้าระหว่างประเทศ", "code": "1111"},
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
                            builder: (context) => ShowSearchData(code: value)));
                    //code = value;
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
    print('test value $value');
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowSearchData(code: value)));
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
