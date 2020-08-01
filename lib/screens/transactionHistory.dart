import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:win75/controllers/transaction_controllers.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/constants.dart';

class TransactionHistory extends StatefulWidget {
  static const id = '/transaction_history';
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Transactions"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 5),
              color: Colors.deepPurpleAccent,
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Id",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "Type",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "Amount",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "Status",
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
            Provider.of<User>(context).transactions.length != 0
                ? FutureBuilder(
                    future: TransactionControllers.getTransactions(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          (snapshot.connectionState == ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done)) {
                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              Provider.of<User>(context).transactions.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 7);
                          },
                          itemBuilder: (context, index) {
                            print(index);
                            return Container(
                              color: snapshot.data[index].status == success
                                  ? Colors.green
                                  : snapshot.data[index].status == inProgress
                                      ? Colors.yellow
                                      : Colors.redAccent,
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data[index].transactionId,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    snapshot.data[index].type,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    snapshot.data[index].amount.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    snapshot.data[index].status,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    softWrap: true,
                                  )
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
                    "No transactions yet",
                    style: Theme.of(context).textTheme.headline1,
                  ),
          ],
        ),
      ),
    );
  }
}
