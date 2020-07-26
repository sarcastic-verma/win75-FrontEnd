import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:win75/controllers/user_controllers.dart';
import 'package:win75/models/User.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
            future: UserController.fetchLeaderBoard(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done)) {
                if (snapshot.data.length != 0) {
                  List<TableRow> leaderUsers = [];
                  int i = 1;
                  for (User user in snapshot.data) {
                    leaderUsers.add(TableRow(
                        decoration: ShapeDecoration(
                            color: i % 2 == 0
                                ? Colors.grey[300]
                                : Colors.green[300],
                            shape: RoundedRectangleBorder()),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${i.toString()}\t\t\t\t\t\t\t",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontSize: 20, fontFamily: "karla"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.username,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontFamily: "karla"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.totalAmountWon.round().toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontFamily: "karla"),
                            ),
                          ),
                        ]));
                    i++;
                  }
                  return Table(
                    columnWidths: {
                      0: FlexColumnWidth(0.3),
                      1: FlexColumnWidth(0.4),
                      2: FlexColumnWidth(0.3)
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    children: [
                      TableRow(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            color: Theme.of(context).accentColor),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Text(
                              "Rank",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(fontFamily: "karla"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Name",
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(fontFamily: "karla")),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Text("Wins",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(fontFamily: "karla")),
                          )
                        ],
                      ),
                      ...leaderUsers,
                      TableRow(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            color: Theme.of(context).accentColor),
                        children: [
                          Text(
                            "",
                          ),
                          Text(
                            "",
                          ),
                          Text(
                            "",
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Table(
                    children: [
                      TableRow(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            color: Theme.of(context).accentColor),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Text(
                              "S.No",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Name",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Text("Winnings",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline2),
                          )
                        ],
                      ),
                      TableRow(children: [
                        Text(
                          "No",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text("Players",
                            style: Theme.of(context).textTheme.headline3),
                        Text("Yet",
                            style: Theme.of(context).textTheme.headline3)
                      ])
                    ],
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                    child: Text(
                  "something went wrong,\nplease try again later",
                  style: Theme.of(context).textTheme.headline2,
                ));
              } else {
                return Center(
                  child: SpinKitCubeGrid(
                    color: Theme.of(context).accentColor,
                  ),
                );
              }
            }),
      ),
    );
  }
}
