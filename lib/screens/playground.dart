import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win75/components/GamePage.dart';

class PlayGround extends StatefulWidget {
  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: TabBarView(children: [
            GameTab(),
            GameTab(),
            GameTab(),
            GameTab(),
          ]),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: isComplete
              ? FlatButton(
                  onPressed: () {
                    setState(() {
                      isComplete = false;
                    });
                  },
                  child: Text("re-start"),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularCountDownTimer(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 5,
                      color: Colors.black,
                      fillColor: Colors.red,
                      strokeWidth: 15.0,
                      textStyle: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      isReverse: true,
                      duration: 15,
                      onComplete: () {
                        print("Helo");
                        setState(() {
                          isComplete = true;
                        });
                      },
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Submit"),
                    )
                  ],
                ),
        )
      ],
    )));
  }
}
