import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOption extends StatelessWidget {
  final String optionImage;
  CustomOption({this.optionImage});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
//          padding: EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            width: 40,
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: RadialGradient(colors: [Colors.green, Colors.black])),
            child: Center(
              child: Text(
                "-",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
          ),
        ),
        Image(
          image: AssetImage(optionImage),
          height: 45,
          width: 45,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
//          padding: EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            width: 40,
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: RadialGradient(colors: [Colors.green, Colors.black])),
            child: Center(
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
