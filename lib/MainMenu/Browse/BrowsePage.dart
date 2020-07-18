import 'package:flutter/material.dart';

class BrowsePage extends StatefulWidget {
  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
 @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Card(
                margin: EdgeInsets.only(left: 8.0, top: 20.0),
                child: Container(
                  height: 220.0,
                  width: 367.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/468x280?text=Promotion+or+News")
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              title: Text("บทความจากทนาย"),
            ),
            _buildNewCard()
          ],
        ),
      ],
    );
  }
  String testImage = 'https://mk0yricg5fo7xqo5up.kinstacdn.com/wp-content/uploads/2018/05/new-approaches-to-law-school-student-debt-506x253.jpg';

  _buildNewCard(){
    return Container(
              height: 3000,
              child: CustomScrollView(
               physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 3000.0, // image height
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemExtent: 315,
                        itemCount: 5, //image width
                        //itemCount: allVdoObject.vdolist.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => 
                        Container(
                            height: 150.0,
                            margin: EdgeInsets.all(5.0),
                            child: Card(
                              child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 242.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(testImage),
                                          fit: BoxFit.cover)
                                          ),
                                  child: GestureDetector(
                                    onTap: () {
                                      
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 250.0,
                                      bottom: 10.0
                                    ),
                                  height: 250.0,
                                  child: Text(
                                    "บทความ 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            );
  }

}