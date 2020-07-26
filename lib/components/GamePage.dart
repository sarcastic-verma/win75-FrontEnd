import 'package:flutter/material.dart';
import 'package:win75/components/CustomOption.dart';

class GameTab extends StatefulWidget {
  @override
  _GameTabState createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomOption(
            optionImage: "assets/images/spade.png",
          ),
          CustomOption(
            optionImage: "assets/images/Diamond.png",
          ),
          CustomOption(
            optionImage: "assets/images/Heart.png",
          ),
          CustomOption(
            optionImage: "assets/images/club.png",
          ),
          ListTile(
            title: Text("Total Amount Spent in this game"),
          )
        ],
      ),
    );
  }
}
