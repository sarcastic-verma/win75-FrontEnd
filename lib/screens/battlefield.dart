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
    print(_myTime);
    return _myTime;
  }

  @override
  void initState() {
    getTime();
    super.initState();
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
                child: (snapshot.data.hour >= 1 && snapshot.data.hour <= 18)
                    ? Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TabBarView(children: [
                              GamePage(
                                betAmount: 50,
                                type: "battle",
                              ),
                              GamePage(
                                betAmount: 100,
                                type: "battle",
                              ),
                              GamePage(
                                betAmount: 500,
                                type: "battle",
                              ),
                              GamePage(
                                betAmount: 1000,
                                type: "battle",
                              ),
                            ]),
                          ),
                          Positioned(
                            bottom: 10,
//          right: 0,
                            left: 50,
                            child: isComplete
                                ? Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: FlatButton(
                                      color: Colors.yellow,
                                      onPressed: () {
                                        setState(() {
                                          isComplete = false;
                                        });
                                      },
                                      child: Text(
                                        "Re-Start",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  )
                                : CircularCountDownTimer(
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    color: Colors.black,
                                    fillColor: Colors.red,
                                    strokeWidth: 15.0,
                                    textStyle: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                    isReverse: true,
                                    duration: 3600,
                                    onComplete: () {
                                      print("Helo");
                                      setState(() {
                                        isComplete = true;
                                      });
                                    },
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
