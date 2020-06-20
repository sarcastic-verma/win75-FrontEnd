import 'package:flutter/material.dart';

class ComeLater extends StatefulWidget {
  static const id = '/comeLater';
  @override
  _ComeLaterState createState() => _ComeLaterState();
}

class _ComeLaterState extends State<ComeLater> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Get current time',
        child: new Icon(Icons.timer),
        onPressed: () {},
      ),
      appBar: new AppBar(
        title: new Text('Example TrueTime app'),
      ),
      body: new Column(
        children: <Widget>[
          new Text('TrueTime is initialized: '),
          new Text('Current Time: \n'),
        ],
      ),
    );
  }
}
