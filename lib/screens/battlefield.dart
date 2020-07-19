import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ntp/ntp.dart';
import 'package:win75/components/GamePage.dart';
import 'package:win75/components/comeLater.dart';

class BattleFieldScreen extends StatefulWidget {
  static const String id = "/battlefield";

  @override
  _BattleFieldScreenState createState() => _BattleFieldScreenState();
}

class _BattleFieldScreenState extends State<BattleFieldScreen> {
  bool isComplete = false;
  DateTime _myTime;
  Future getTime() async {
    _myTime = await NTP.now();
  }

  @override
  void initState() {
    super.initState();
//    getTime();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: (_myTime.hour >= 1 && _myTime.hour <= 18)
                    ? Stack(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircularCountDownTimer(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
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
                      )
                    : ComeLater(),
              );
            } else {
              return Center(
                child: SpinKitCubeGrid(
                  color: Colors.amber,
                ),
              );
            }
          }),
    );
  }
}
