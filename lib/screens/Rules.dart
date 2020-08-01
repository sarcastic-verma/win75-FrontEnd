import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  static const id = '/Rules';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rules"),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              "* Take a nice little paper",
              style: Theme.of(context).textTheme.headline1,
            ),
            Divider(
              thickness: 3,
              color: Theme.of(context).accentColor,
            ),
            Text("* Roll it into a cylinder",
                style: Theme.of(context).textTheme.headline1),
            Divider(
              thickness: 3,
              color: Theme.of(context).accentColor,
            ),
            Text("* Make it sharp and pointy",
                style: Theme.of(context).textTheme.headline1),
            Divider(
              thickness: 3,
              color: Theme.of(context).accentColor,
            ),
            Text("* And shove it up your nose",
                style: Theme.of(context).textTheme.headline1)
          ],
        ));
  }
}
