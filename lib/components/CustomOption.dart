import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOption extends StatefulWidget {
  final String optionName;
  final Set<String> chosenOptions;
  final Function(Set<String>) callback;
  CustomOption(
      {@required this.optionName,
      @required this.callback,
      @required this.chosenOptions});

  @override
  _CustomOptionState createState() => _CustomOptionState();
}

class _CustomOptionState extends State<CustomOption> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: selected ? Theme.of(context).accentColor : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              widget.chosenOptions.remove(widget.optionName);
              widget.callback(widget.chosenOptions);
              setState(() {
                selected = false;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//          padding: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              width: 40,
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  gradient:
                      RadialGradient(colors: [Colors.green, Colors.black])),
              child: Center(
                child: Text(
                  "-",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
            ),
          ),
          Image(
            image: AssetImage("assets/images/${widget.optionName}.png"),
            height: selected ? 45 : 35,
            width: 45,
          ),
          InkWell(
            onTap: () {
              widget.chosenOptions.add(widget.optionName);
              widget.callback(widget.chosenOptions);
              setState(() {
                selected = true;
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
//          padding: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              width: 40,
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  gradient:
                      RadialGradient(colors: [Colors.green, Colors.black])),
              child: Center(
                child: Text(
                  "+",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
