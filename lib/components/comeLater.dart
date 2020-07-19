import 'package:flutter/material.dart';

class ComeLater extends StatefulWidget {
  @override
  _ComeLaterState createState() => _ComeLaterState();
}

class _ComeLaterState extends State<ComeLater> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(
              "You stumbled here at the wrong time!!!\nCome Between 3-6PM",
              style: TextStyle(fontFamily: "Pacifico", fontSize: 20),
            ),
          ),
          Image(
            image: AssetImage("assets/images/come_later.gif"),
          ),
        ],
      ),
    );
  }
}
