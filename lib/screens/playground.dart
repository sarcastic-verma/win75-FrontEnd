import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:win75/components/PlayGamePage.dart';
import 'package:win75/components/pages.dart';
import 'package:win75/controllers/transaction_controllers.dart';
import 'package:win75/models/Game.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/auth.dart';
import 'package:win75/utilities/constants.dart';
import 'package:win75/utilities/sampleGames.dart';

class PlayGround extends StatefulWidget {
  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  bool isComplete = false;
  bool played50Game = false;
  bool played100Game = false;
  bool played500Game = false;
  bool played1000Game = false;
  Set game50Options;
  Set game100Options;
  Set game500Options;
  Set game1000Options;
  int total50Gain;
  List dropped50Options;
  List dropped100Options;
  List dropped500Options;
  List dropped1000Options;
  int total100Gain;
  int total500Gain;
  int total1000Gain;

  Future updateGains() async {
    List temp;
    if (played50Game) {
      temp =
          await calcGameResult(50, game50Options, PlaygroundGames.random50Game);
      total50Gain = temp[0];
      dropped50Options = temp[1];
    }
    if (played100Game) {
      temp = await calcGameResult(
          100, game100Options, PlaygroundGames.random100Game);
      total100Gain = temp[0];
      dropped100Options = temp[1];
    }

    if (played500Game) {
      temp = await calcGameResult(
          500, game500Options, PlaygroundGames.random500Game);
      total500Gain = temp[0];
      dropped500Options = temp[1];
    }

    if (played1000Game) {
      temp = await calcGameResult(
          1000, game1000Options, PlaygroundGames.random1000Game);
      total1000Gain = temp[0];
      dropped1000Options = temp[1];
    }
    print("in updaet");
  }

  @override
  void initState() {
    print("playgroud...re");
    super.initState();
  }

  callback(int amount, Set options) {
    print("in call back");
    setState(() {
      if (amount == 50) {
        played50Game = true;
        game50Options = options;
      } else if (amount == 100) {
        played100Game = true;
        game100Options = options;
      } else if (amount == 500) {
        played500Game = true;
        game500Options = options;
      } else {
        played1000Game = true;
        game1000Options = options;
      }
    });
    print("done call back");
    print(played100Game);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        !isComplete
            ? Container(
                padding: EdgeInsets.all(10),
                child: TabBarView(children: [
                  PlayGamePage(
                    betAmount: 50,
                    gamePageCallback: callback,
                  ),
                  PlayGamePage(
                    betAmount: 100,
                    gamePageCallback: callback,
                  ),
                  PlayGamePage(
                    betAmount: 500,
                    gamePageCallback: callback,
                  ),
                  PlayGamePage(
                    betAmount: 1000,
                    gamePageCallback: callback,
                  ),
                ]),
              )
            : Container(
                alignment: Alignment.center,
                child: Text(
                  "It's restart time y'all!!",
                  style: Theme.of(context).textTheme.headline1,
                ),
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
                      Navigator.popAndPushNamed(context, Pages.id,
                          arguments: 2);
                    },
                    child: Text(
                      "Re-Start",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )
              : CircularCountDownTimer(
                  width: MediaQuery.of(context).size.width / 2.9,
                  height: MediaQuery.of(context).size.height / 6,
                  color: Colors.black,
                  fillColor: Colors.red,
                  strokeWidth: 15.0,
                  textStyle: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  isReverse: true,
                  duration: 15,
                  onComplete: () async {
                    try {
                      print(played100Game);
                      if (played1000Game ||
                          played500Game ||
                          played100Game ||
                          played50Game) {
                        print("in if");
                        Fluttertoast.showToast(msg: "Calculating");
                        await updateGains();
                        setState(() {
                          print("in setstate");
                        });
                        Alert(
                            style: kAlertStyle,
                            title: "Results of this Slot:-",
                            desc:
                                "(Winning amount is per option.\nInvestment on winning option will be\n returned as it is.)",
                            buttons: [
                              DialogButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Ok",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              )
                            ],
                            context: context,
                            content: Column(
                              children: [
                                played50Game
                                    ? Text(
                                        "Amount won in bet 50 game:   $total50Gain\nLosing Options: $dropped50Options",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      )
                                    : SizedBox(),
                                played100Game
                                    ? Text(
                                        "Amount won in bet 100 game:  $total100Gain\nLosing Options: $dropped100Options",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3)
                                    : SizedBox(),
                                played500Game
                                    ? Text(
                                        "Amount won in bet 500 game:  $total500Gain\nLosing Options: $dropped500Options",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3)
                                    : SizedBox(),
                                played1000Game
                                    ? Text(
                                        "Amount won in bet:1000 game is $total1000Gain\nLosing Options: $dropped1000Options",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3)
                                    : SizedBox()
                              ],
                            )).show();
                      } else {
                        print("Not played anygame");
                      }
                    } catch (err) {
                      print(err);
                    }
                    setState(() {
                      isComplete = true;
                    });
                  },
                ),
        )
      ],
    )));
  }

  Future<List> calcGameResult(
      int betAmount, Set playChosenOptions, Game sampleGame) async {
    print(sampleGame.betValue);
    print(sampleGame.gameInvestment);
    List results = PlaygroundGames.calcSlotResult(
        gameInvestment:
            sampleGame.gameInvestment + betAmount * playChosenOptions.length,
        heartTotalInvestment: playChosenOptions.contains('HEART')
            ? sampleGame.heartTotalInvestment + betAmount
            : sampleGame.heartTotalInvestment,
        clubTotalInvestment: playChosenOptions.contains('CLUB')
            ? sampleGame.clubTotalInvestment + betAmount
            : sampleGame.clubTotalInvestment,
        spadesTotalInvestment: playChosenOptions.contains('SPADE')
            ? sampleGame.spadesTotalInvestment + betAmount
            : sampleGame.spadesTotalInvestment,
        diamondTotalInvestment: playChosenOptions.contains('DIAMOND')
            ? sampleGame.diamondTotalInvestment + betAmount
            : sampleGame.diamondTotalInvestment,
        playerCount: sampleGame.playerCount + 1);
    List droppedOptions = results[1];
    double distributableProfitPercent = results[4];
    print(droppedOptions);
    print(distributableProfitPercent);
    await TransactionControllers.reducePoints(
        amount: betAmount * playChosenOptions.length);
    Set acceptedOptions = playChosenOptions;

    acceptedOptions.removeWhere((element) => droppedOptions.contains(element));
    print(acceptedOptions);
    print(playChosenOptions);
    int profitableInvestment = acceptedOptions.length * betAmount;
    double proportionalGain =
        profitableInvestment * distributableProfitPercent / 100;
    int totalGain = (proportionalGain + profitableInvestment).toInt();
    await TransactionControllers.addPoints(amount: totalGain);
    User user = Provider.of<User>(context, listen: false);
    AuthService().updateUserSharedPreferences(
      mobile: user.mobile,
      games: user.games,
      inWalletCash: user.inWalletCash,
      totalAmountSpent: user.totalAmountSpent,
      totalAmountWon: user.totalAmountWon,
      points: user.points + totalGain,
      username: user.username,
      transactions: user.transactions,
    );
    Provider.of<User>(context, listen: false).updateUser(
        inWalletCash: user.inWalletCash,
        points: user.points + totalGain,
        username: user.username,
        transactions: user.transactions,
        games: user.games,
        mobile: user.mobile);
    return [totalGain - betAmount * playChosenOptions.length, droppedOptions];
  }
}
