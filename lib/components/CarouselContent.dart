import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win75/screens/authentication.dart';

class Content extends StatelessWidget {
  final String title;
  final bool showButton;
  final String desc;
  final bool showImage;
  final double height;
  final double width;
  final String imageName;
  Content(
      {@required this.title,
      this.height,
      this.width,
      this.imageName,
      @required this.showButton,
      @required this.desc,
      @required this.showImage});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.indigo[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(desc,
                style: TextStyle(
                    height: 1.5,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
                textAlign: TextAlign.center),
          ),
          showImage == true
              ? Image(
                  width: width,
                  height: height,
                  image: AssetImage("assets/images/$imageName.png"),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
          showButton == true
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RaisedButton(
                    elevation: 5,
                    onPressed: () async {
                      await Navigator.pushNamed(context, AuthScreen.id);
                    },
                    color: Color(0xff121D30),
                    child: Text("Lets get going",
                        style: TextStyle(), textAlign: TextAlign.center),
                  ),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
