import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(),
    );
  }
}
