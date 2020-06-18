import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win75/components/CarouselContent.dart';

class IntroScreen extends StatelessWidget {
  static const String id = "/intro";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30),
      height: double.infinity,
//      decoration: BoxDecoration(
//        gradient: kIntroGradient,
//      ),
      child: CarouselSlider(
        items: [
          Content(
            title: "hi",
            showButton: false,
            showImage: false,
            desc: "lol",
          ),
          Content(
            title: "hi",
            showButton: true,
            showImage: false,
            desc: "lol",
          )
        ],
        options: CarouselOptions(
          height: 400,
          scrollPhysics: BouncingScrollPhysics(),
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
//          height: 500,
        ),
      ),
    ));
  }
}
