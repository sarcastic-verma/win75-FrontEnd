import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:win75/controllers/game_controllers.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/PlayerSummaryDetails.dart';

class GamesHistory extends StatefulWidget {
  static const id = '/games_history';
  @override
  _GamesHistoryState createState() => _GamesHistoryState();
}

class _GamesHistoryState extends State<GamesHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Games"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Provider.of<User>(context).games.length != 0
                ? FutureBuilder(
                    future: GameControllers.getGamesByUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          (snapshot.connectionState == ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done)) {
                        if (snapshot.data.length == 0) {
                          return Center(
                            child: Text(
                              "Something went wrong!!\nTry again later!!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          );
                        } else
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: Provider.of<User>(context).games.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: ShapeDecoration(
                                    color: Theme.of(context).accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                padding: const EdgeInsets.all(12.0),
                                child: Card(
                                  color: Colors.amber,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Date: ${snapshot.data[index].startTime.split('T')[0]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(color: Colors.pink),
                                      ),
                                      Text(
                                        "\nStart Time: ${snapshot.data[index].startTime.split('T')[1].substring(0, 5)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Text(
                                        "\nBet Value: ${snapshot.data[index].betValue.toString()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Text(
                                        snapshot.data[index].isComplete
                                            ? "\nLosing Options: \n${snapshot.data[index].droppedOptions.toString()}"
                                            : "\nOnGoing",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        softWrap: true,
                                      ),
                                      snapshot.data[index].isComplete
                                          ? RaisedButton(
                                              color:
                                                  Theme.of(context).accentColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    PlayerSummaryDetails.id,
                                                    arguments: snapshot
                                                        .data[index].gid);
                                              },
                                              child: Text("Details.."),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Center(
                            child: Text(
                          "Something went wrong,\nplease try again later",
                          style: Theme.of(context).textTheme.headline2,
                        ));
                      } else {
                        return Center(
                          child: SpinKitCubeGrid(
                            color: Theme.of(context).accentColor,
                          ),
                        );
                      }
                    })
                : Center(
                    child: Text(
                      "No games played yet",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
