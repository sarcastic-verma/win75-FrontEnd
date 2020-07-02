import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ntp/ntp.dart';
import 'package:win75/components/GamePage.dart';
import 'package:win75/screens/comeLater.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isComplete = false;
  DateTime _myTime;
  Future getTime() async {
    _myTime = await NTP.now();
    print('My time: $_myTime ${_myTime.hour}');
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
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
//          flexibleSpace: ,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70))),
          automaticallyImplyLeading: false,
          bottom: TabBar(
//            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                child: Text("50"),
              ),
              Tab(
                child: Text("100"),
              ),
              Tab(
                child: Text("500"),
              ),
              Tab(
                child: Text("1000"),
              )
            ],
          ),
        ),
        body: FutureBuilder(
            future: getTime(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SafeArea(
                  child: (_myTime.hour >= 15 && _myTime.hour <= 18)
                      ? Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TabBarView(children: [
                                GamePage(),
                                GamePage(),
                                GamePage(),
                                GamePage(),
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
                                  : CircularCountDownTimer(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
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
                            )
                          ],
                        )
                      : ComeLater(),
                );
              } else {
                return SpinKitCubeGrid(
                  color: Colors.amber,
                );
              }
            }),
      ),
    );
  }
}
