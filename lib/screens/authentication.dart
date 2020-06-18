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
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              colorFilter: ColorFilter.mode(Colors.purple, BlendMode.colorBurn),
//              fit: BoxFit.cover,
//              image: AssetImage("assets/images/login101.jpeg"),
//            ),
//          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Brusque",
//                    style: kAuthHeaderTextStyle,
                  ),
                  Text(
                    "\nSpread your creative in",
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
                    color: Colors.pink,
                    child: Text("Login", style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginIn.id);
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
                    color: Colors.purple,
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
