import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const id = '/aboutUS';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "About Us",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          Divider(
            thickness: 4,
          ),
          Text(
            "\nWe are students of bennett university. We aim to provide people with an option to earn some quick money.",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Divider(
            thickness: 4,
          ),
          Text(
            "About Game",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            "New quizes are uploaded every day. Each quiz has 4 options and none of those are pr-decided to be correct. Meaning, in the end players who placed a bet on any of the 3 options with minimum bets (displayed at the time of result) will be considered the winners. \nWinning amount will be in a range of 25% to 100% of their initial bet, depending on the number of players placing bets. \nFor example:\nQ.Choose an option\nA. Spade\nB. Club\nC. Heart\nD. Diamond\nNow,\n100 players placed a bet on A \n150 players placed a bet on B\n 200 players placed a bet on C \n180 players placed a bet on D \nThen every player who placed a bet on any of A, B or D will win.\nHere, Heart was the wrong answer because maximum people placed a bet on option C. Heart.",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
