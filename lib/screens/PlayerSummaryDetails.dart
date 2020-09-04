import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:win75/controllers/player_summary_controllers.dart';
import 'package:win75/models/PlayerSummary.dart';

class PlayerSummaryDetails extends StatelessWidget {
  static const id = '/details';
  final String gameId;
  PlayerSummaryDetails({@required this.gameId});
  @override
  Widget build(BuildContext context) {
    print(gameId);
    return Scaffold(
      body: FutureBuilder(
          future: PlayerSummaryControllers.getPlayerSummary(gameId: gameId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != false) {
                PlayerSummary playerSummary = snapshot.data;
                print(playerSummary);
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: EdgeInsets.all(20),
                  decoration: ShapeDecoration(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Details!!",
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "\nOpted Options: \n${playerSummary.optedOptions}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        "\nProfitable Options: \n${playerSummary.acceptedOptions}",
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "\nTotal Gain\n(including investment): \n${playerSummary.totalGain.toString()}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Text(
                  "Something went wrong,\nplease try again later",
                  style: Theme.of(context).textTheme.headline3,
                ));
              }
            } else {
              return Center(
                  child: SpinKitCubeGrid(
                color: Theme.of(context).accentColor,
              ));
            }
          }),
    );
  }
}
