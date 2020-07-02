import 'package:flutter/material.dart';

class CustomOption extends StatelessWidget {
  final String optionName;
  CustomOption({this.optionName});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RaisedButton(
          onPressed: () {
            print("bet removed");
          },
          child: Text("-"),
        ),
        Text(optionName),
        RaisedButton(
          onPressed: () {
            print("bet placed");
          },
          child: Text("+"),
        )
      ],
    );
  }
}
