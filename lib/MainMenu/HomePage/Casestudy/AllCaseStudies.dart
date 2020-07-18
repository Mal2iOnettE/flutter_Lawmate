

import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/AllCaseStudy_ThreeCases/AllCase_CivilLaw.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/AllCaseStudy_ThreeCases/AllCase_CriminalLaw.dart';
import 'package:final_project_ver_2/MainMenu/HomePage/Casestudy/AllCaseStudy_ThreeCases/AllCase_Other.dart';
import 'package:flutter/material.dart';
class AllCaseStudies extends StatefulWidget {
  @override
  _AllCaseStudiesState createState() => _AllCaseStudiesState();
}

class _AllCaseStudiesState extends State<AllCaseStudies> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        /*FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }*/
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("All Cases"),
            backgroundColor: Color(0xFF010037),
            bottom: TabBar(
              indicatorColor: Color(0xFF010037),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: "แพ่ง",
                  icon: Icon(Icons.timer),
                ),
                Tab(
                  text: "อาญา",
                  icon: Icon(Icons.history),
                ),
                Tab(
                  text: "อื่นๆ",
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            AllCase_CivilLaw(),
            AllCase_CriminalLaw(),
            AllCase_Other(),
          ]),
        ),
      ),
    );
  }

 
}
