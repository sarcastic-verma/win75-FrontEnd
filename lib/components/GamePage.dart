import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:win75/components/CustomOption.dart';
import 'package:win75/controllers/player_summary_controllers.dart';
import 'package:win75/models/GamesProvider.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/auth.dart';

class GamePage extends StatefulWidget {
  final int betAmount;
  final String type;
  final Function(int amount, Set options) gamePageCallback;

  final String gameId;

  GamePage(
      {@required this.betAmount,
      this.gamePageCallback,
      @required this.type,
      this.gameId});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with AutomaticKeepAliveClientMixin<GamePage> {
  @override
  bool get wantKeepAlive => true;

  DateTime _myTime;
  bool isAsyncCall = false;

  Future getTime() async {
    _myTime = await NTP.now();
    print("game page ka $_myTime");
    return _myTime;
  }

  void handleSubmitted() async {
    _myTime = await NTP.now();
    print("handle $_myTime");
    if (_myTime.hour < 16 && _myTime.hour >= 15)
      checkGameState(
          rebuild: true,
          result:
              Provider.of<GamesProvider>(context, listen: false).played3to4);
    else if (_myTime.hour < 17 && _myTime.hour >= 16)
      checkGameState(
          rebuild: true,
          result:
              Provider.of<GamesProvider>(context, listen: false).played4to5);
    else if (_myTime.hour < 18 && _myTime.hour >= 17)
      checkGameState(
          rebuild: true,
          result:
              Provider.of<GamesProvider>(context, listen: false).played5to6);
  }

  Set<String> playChosenOptions = {};
  List<String> battleChosenOptions;
  bool isSubmitted = false;

  callback(newChosenOptions) {
    setState(() {
      playChosenOptions = newChosenOptions;
    });
    print(playChosenOptions);
  }

  void checkGameState({String result, bool rebuild}) {
    print("here it is $result");
    if (result != null) {
      List submittedGames = result.split(":");
      submittedGames.removeLast();
      List options;
      if (submittedGames.length > 0) {
        submittedGames.forEach((element) {
          List gameData = element.split("_");
          if (gameData[0] == widget.betAmount.toString()) {
            print(gameData[0]);
            print("ioioi");
            print(gameData[1]);
            options =
                gameData[1].substring(1, gameData[1].length - 1).split(",");
            print(options);
          }
        });
        if (rebuild == false) {
          battleChosenOptions = options;
        } else {
          setState(() {
            battleChosenOptions = options;
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.type != "play") handleSubmitted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return battleChosenOptions != null && widget.type != "play"
        ? FutureBuilder(
            future: getTime(),
            builder: (context, snapshot) {
              String result;
              if (snapshot.hasData) {
                if (snapshot.data.hour < 16 && snapshot.data.hour >= 15) {
                  result = Provider.of<GamesProvider>(context).played3to4;
                } else if (snapshot.data.hour < 17 &&
                    snapshot.data.hour >= 16) {
                  result = Provider.of<GamesProvider>(context).played4to5;
                } else if (snapshot.data.hour < 18 &&
                    snapshot.data.hour >= 17) {
                  result = Provider.of<GamesProvider>(context).played5to6;
                }
                checkGameState(result: result, rebuild: false);
//                print(Provider.of<GamesProvider>(context).played3to4);
                return Column(
                  children: [
                    Text(
                      "\nYou have submitted this game.\nYou chose:-\n",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    ...List.generate(
                      battleChosenOptions.length,
                      (index) => Container(
                        margin: EdgeInsets.all(10),
                        child: Image(
                          image: AssetImage(
                              "assets/images/${battleChosenOptions.elementAt(index).trim()}.png"),
                          height: 45,
                          width: 45,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SpinKitCubeGrid(
                  color: Colors.pink,
                );
              }
            })
        : isSubmitted
            ? Column(
                children: [
                  Text(
                    "\nYou have submitted this game.\nYou chose:-\n",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  ...List.generate(
                    playChosenOptions.length,
                    (index) => Image(
                      image: AssetImage(
                          "assets/images/${playChosenOptions.elementAt(index)}.png"),
                      height: 45,
                      width: 45,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomOption(
                    optionName: "SPADES",
                    callback: callback,
                    chosenOptions: playChosenOptions,
                  ),
                  CustomOption(
                    optionName: "DIAMOND",
                    chosenOptions: playChosenOptions,
                    callback: callback,
                  ),
                  CustomOption(
                    optionName: "HEART",
                    callback: callback,
                    chosenOptions: playChosenOptions,
                  ),
                  CustomOption(
                    optionName: "CLUB",
                    callback: callback,
                    chosenOptions: playChosenOptions,
                  ),
                  ListTile(
                    title: Text(
                      "Amount Spent in this game:  ${widget.betAmount * playChosenOptions.length}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.values[1],
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            disabledColor: Colors.grey[300],
                            onPressed: playChosenOptions.length == 0
                                ? null
                                : widget.type == 'play'
                                    ? Provider.of<User>(context).points >=
                                            widget.betAmount *
                                                playChosenOptions.length
                                        ? () async {
                                            setState(() {
                                              isSubmitted = true;
                                            });
                                            User user = Provider.of<User>(
                                                context,
                                                listen: false);
                                            await AuthService()
                                                .updateUserSharedPreferences(
                                              mobile: user.mobile,
                                              games: user.games,
                                              inWalletCash: user.inWalletCash,
                                              totalAmountSpent:
                                                  user.totalAmountSpent,
                                              totalAmountWon:
                                                  user.totalAmountWon,
                                              points: user.points -
                                                  widget.betAmount *
                                                      playChosenOptions.length,
                                              username: user.username,
                                              transactions: user.transactions,
                                            );
                                            Provider.of<User>(context,
                                                    listen: false)
                                                .updateUser(
                                                    inWalletCash:
                                                        user.inWalletCash,
                                                    points: user.points -
                                                        widget.betAmount *
                                                            playChosenOptions
                                                                .length,
                                                    username: user.username,
                                                    transactions:
                                                        user.transactions,
                                                    games: user.games,
                                                    mobile: user.mobile);

                                            widget.gamePageCallback(
                                                widget.betAmount,
                                                playChosenOptions);
                                            print('hey man');
                                            print(
                                                "after hey: the val of submitted is $isSubmitted");
                                          }
                                        : null
                                    : Provider.of<User>(context).inWalletCash >=
                                            widget.betAmount *
                                                playChosenOptions.length
                                        ? () async {
                                            Fluttertoast.showToast(
                                                msg: "Submitting game");
                                            bool response =
                                                await PlayerSummaryControllers
                                                    .makePlayerSummary(
                                                        gameId: widget.gameId,
                                                        optedOptions:
                                                            playChosenOptions
                                                                .toList());
                                            if (response) {
                                              widget.gamePageCallback(
                                                  widget.betAmount,
                                                  playChosenOptions);
                                              User user = Provider.of<User>(
                                                  context,
                                                  listen: false);
                                              List userGames = user.games;
                                              userGames.add(widget.gameId);
                                              AuthService()
                                                  .updateUserSharedPreferences(
                                                mobile: user.mobile,
                                                games: userGames,
                                                inWalletCash:
                                                    user.inWalletCash -
                                                        widget.betAmount *
                                                            playChosenOptions
                                                                .length,
                                                totalAmountSpent:
                                                    user.totalAmountSpent,
                                                totalAmountWon:
                                                    user.totalAmountWon,
                                                points: user.points,
                                                username: user.username,
                                                transactions: user.transactions,
                                              );
                                              Provider.of<User>(context,
                                                      listen: false)
                                                  .updateUser(
                                                      inWalletCash: user
                                                              .inWalletCash -
                                                          widget.betAmount *
                                                              playChosenOptions
                                                                  .length,
                                                      points: user.points,
                                                      username: user.username,
                                                      transactions:
                                                          user.transactions,
                                                      games: userGames,
                                                      mobile: user.mobile);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Error submitting game");
                                              setState(() {
                                                isSubmitted = false;
                                              });
                                            }
                                          }
                                        : null,
                            color: Theme.of(context).accentColor,
                            child: Text(
                              "Submit",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ]),
                  )
                ],
              );
  }
}
