import 'package:final_project_ver_2/Login/LoginByPhoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroPages extends StatefulWidget {
  @override
  _IntroPagesState createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {

  List<Slide> slides = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(
      new Slide(
        title: "intro 01",
        description: "555 this is the FIRST intro page !!!" ,
        backgroundColor: Colors.amber
      ),
    );
    slides.add(
      new Slide(
        title: "intro 02",
        description: "555 this is the SECOND intro page !!!" ,
        backgroundColor: Colors.amber
      ),
    );
    slides.add(
      new Slide(
        title: "intro 03",
        description: "555 this is the THIRD intro page !!!" ,
        backgroundColor: Colors.amber
      ),
    );
  }
  void onDonePress(){
   Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginByPhoneNumber()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onDonePress,
    );
  }
}