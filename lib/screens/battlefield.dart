import 'dart:collection';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:win75/components/GamePage.dart';
import 'package:win75/components/comeLater.dart';
import 'package:win75/components/pages.dart';
import 'package:win75/controllers/window_controllers.dart';
import 'package:win75/models/GamesProvider.dart';
import 'package:win75/utilities/GameService.dart';

class BattleFieldScreen extends StatefulWidget {
  static const String id = "/battlefield";

  @override
  _BattleFieldScreenState createState() => _BattleFieldScreenState();
}

class _BattleFieldScreenState extends State<BattleFieldScreen> {
  bool isComplete = false;
  DateTime _myTime;
  Future getTimeAndGames() async {
    _myTime = await NTP.now();
    print(_myTime);
    LinkedHashMap gamesId;
    gamesId = await WindowControllers.getCurrentWindow();
    if (_myTime.hour > 18 || _myTime.hour < 15) {
      await GameService.removeGameSharedPreferences();
      Provider.of<GamesProvider>(context, listen: false).removeSlots();
    }
    if (gamesId == null) {
      print("shitt");
      return null;
    } else
      return [_myTime, gamesId];
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTimeAndGames();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callback(int amount, Set options) async {
    GamesProvider gamesProvider =
        Provider.of<GamesProvider>(context, listen: false);
    setState(() {
      if (_myTime.hour < 16 && _myTime.hour >= 15) {
        String result = amount.toString() + "_" + options.toString();
        if (gamesProvider.played3to4 == null) {
          gamesProvider.played3to4 = "";
        }
        gamesProvider.played3to4 = gamesProvider.played3to4 + result + ":";
        Provider.of<GamesProvider>(context, listen: false).updateSlots(
            played3to4: gamesProvider.played3to4,
            played4to5: gamesProvider.played4to5,
            played5to6: gamesProvider.played5to6);
      } else if (_myTime.hour < 17 && _myTime.hour >= 16) {
        String result = amount.toString() + "_" + options.toString();
        if (gamesProvider.played4to5 == null) {
          gamesProvider.played4to5 = "";
        }
        gamesProvider.played4to5 = gamesProvider.played4to5 + result + ":";
        Provider.of<GamesProvider>(context, listen: false).updateSlots(
            played3to4: gamesProvider.played3to4,
            played4to5: gamesProvider.played4to5,
            played5to6: gamesProvider.played5to6);
      } else if (_myTime.hour < 18 && _myTime.hour >= 17) {
        String result = amount.toString() + "_" + options.toString();
        if (gamesProvider.played5to6 == null) {
          gamesProvider.played5to6 = "";
        }
        gamesProvider.played5to6 = gamesProvider.played5to6 + result + ":";
        Provider.of<GamesProvider>(context, listen: false).updateSlots(
            played3to4: gamesProvider.played3to4,
            played4to5: gamesProvider.played4to5,
            played5to6: gamesProvider.played5to6);
      }
    });
    await GameService.storeGameInSharedPreferences(
        gamesProvider: gamesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getTimeAndGames(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Center(
                  child: Text(
                    "Something went wrong.\nTry again later!!",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                );
              }
              print(snapshot.data[1]);
              return isComplete
                  ? Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Results of this game will be updated in Games history\nwithin 2-3mins!!",
                            softWrap: true,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: FlatButton(
                              color: Colors.yellow,
                              onPressed: () {
                                setState(() {
                                  isComplete = false;
                                });
                                Navigator.popAndPushNamed(context, Pages.id,
                                    arguments: 1);
                              },
                              child: Text(
                                "Enter Next Game",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          )
                        ],
                      ))
                  : SafeArea(
                      child: (snapshot.data[0].hour >= 15 &&
                              snapshot.data[0].hour <= 18)
                          ? Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TabBarView(children: [
                                    GamePage(
                                      betAmount: 50,
                                      type: "battle",
                                      gamePageCallback: callback,
                                      gameId: snapshot.data[0].hour == 15
                                          ? snapshot.data[1]["0"][0]
                                          : snapshot.data[0].hour == 16
                                              ? snapshot.data[1]["1"][0]
                                              : snapshot.data[1]["2"][0],
                                    ),
                                    GamePage(
                                        betAmount: 100,
                                        type: "battle",
                                        gamePageCallback: callback,
                                        gameId: snapshot.data[0].hour == 15
                                            ? snapshot.data[1]["0"][1]
                                            : snapshot.data[0].hour == 16
                                                ? snapshot.data[1]["1"][1]
                                                : snapshot.data[1]["2"][1]),
                                    GamePage(
                                        betAmount: 500,
                                        gamePageCallback: callback,
                                        type: "battle",
                                        gameId: snapshot.data[0].hour == 15
                                            ? snapshot.data[1]["0"][2]
                                            : snapshot.data[0].hour == 16
                                                ? snapshot.data[1]["1"][2]
                                                : snapshot.data[1]["2"][2]),
                                    GamePage(
                                        betAmount: 1000,
                                        type: "battle",
                                        gamePageCallback: callback,
                                        gameId: snapshot.data[0].hour == 15
                                            ? snapshot.data[1]["0"][3]
                                            : snapshot.data[0].hour == 16
                                                ? snapshot.data[1]["1"][3]
                                                : snapshot.data[1]["2"][3]),
                                  ]),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 50,
                                  child: CircularCountDownTimer(
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
                                    duration: _myTime != null
                                        ? 3600 - _myTime.minute * 60
                                        : 3600,
                                    onComplete: () async {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Results will be updated in Games History");
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
