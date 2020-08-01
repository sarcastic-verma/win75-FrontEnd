import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win75/components/CustomOption.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/auth.dart';

class GamePage extends StatefulWidget {
  final int betAmount;
  final String type;
  final Function(int amount, Set options) callback;
  GamePage(
      {@required this.betAmount, @required this.callback, @required this.type});
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with AutomaticKeepAliveClientMixin<GamePage> {
  @override
  bool get wantKeepAlive => true;

  Set<String> playChosenOptions = {};

  bool isSubmitted = false;
  callback(newChosenOptions) {
    setState(() {
      playChosenOptions = newChosenOptions;
    });
    print(playChosenOptions);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isSubmitted
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
                                        User user = Provider.of<User>(context,
                                            listen: false);
                                        AuthService()
                                            .updateUserSharedPreferences(
                                          mobile: user.mobile,
                                          games: user.games,
                                          inWalletCash: user.inWalletCash,
                                          totalAmountSpent:
                                              user.totalAmountSpent,
                                          totalAmountWon: user.totalAmountWon,
                                          points: user.points -
                                              widget.betAmount *
                                                  playChosenOptions.length,
                                          username: user.username,
                                          transactions: user.transactions,
                                        );
                                        Provider.of<User>(context,
                                                listen: false)
                                            .updateUser(
                                                inWalletCash: user.inWalletCash,
                                                points: user.points -
                                                    widget.betAmount *
                                                        playChosenOptions
                                                            .length,
                                                username: user.username,
                                                transactions: user.transactions,
                                                games: user.games,
                                                mobile: user.mobile);
                                        widget.callback(widget.betAmount,
                                            playChosenOptions);
                                      }
                                    : null
                                : Provider.of<User>(context).inWalletCash >=
                                        widget.betAmount *
                                            playChosenOptions.length
                                    ? () async {
                                        setState(() {
                                          isSubmitted = true;
                                        });
//                                        widget.callback(widget.betAmount,
//                                            playChosenOptions);
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
