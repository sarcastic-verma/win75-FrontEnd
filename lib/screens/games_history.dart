import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:win75/controllers/game_controllers.dart';
import 'package:win75/models/User.dart';

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
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 5),
              color: Colors.yellow,
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "S.No",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "Slot",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "Losing options",
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
            Provider.of<User>(context).games.length != 0
                ? FutureBuilder(
                    future: GameControllers.getGamesByUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          (snapshot.connectionState == ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done)) {
                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: Provider.of<User>(context).games.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 7);
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.pink,
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    snapshot.data[index].slot,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    snapshot.data[index].droppedOptions
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
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
                : Text(
                    "No games played yet",
                    style: Theme.of(context).textTheme.headline1,
                  ),
          ],
        ),
      ),
    );
  }
}
