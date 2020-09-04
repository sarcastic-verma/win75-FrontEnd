import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win75/screens/signup.dart';

import 'login.dart';

class AuthScreen extends StatelessWidget {
  static const String id = "/auth";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white30, Colors.green])
//            image: DecorationImage(
//              colorFilter: ColorFilter.mode(Colors.purple, BlendMode.colorBurn),
//              fit: BoxFit.cover,
//              image: AssetImage("assets/images/login101.jpeg"),
//            ),
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Win75\n\nWorld's 1st game with",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    "75% Winning Chance",
                    style: Theme.of(context).textTheme.headline3,
//                    style: kAuthTextStyle,
                  ),
                  Text(
                    "*terms and conditions applied",
                    style: Theme.of(context).textTheme.bodyText2,
//                    style: kAuthTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(20),
                    color: Colors.lightGreenAccent,
                    child: Text("Login", style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.greenAccent,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUp.id);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
