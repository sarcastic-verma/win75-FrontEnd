import 'package:flutter/material.dart';
import 'package:win75/components/pages.dart';

import 'login.dart';

class SignUp extends StatelessWidget {
  static const id = '/signup';
  @override
  Widget build(BuildContext context) {
    bool imageSelected = false;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Sign Up",
//                style: kAuthHeaderTextStyle,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
//                  CircleAvatar(
//                    child: Image(
////                      image: FileImage(),
//                        ),
//                  ),
                  TextField(
                    textAlign: TextAlign.center,
//                    decoration: kTextFieldDecoration.copyWith(
//                        hintText: "Enter Username"),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
//                    decoration:
//                        kTextFieldDecoration.copyWith(hintText: "Enter Email"),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
//                    decoration: kTextFieldDecoration.copyWith(
//                        hintText: "Enter password"),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Pages.id);
                    },
                    child: Text(
                      "Go",
//                      style: kTextLoginStyle,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 18, fontFamily: "Pacifico"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, LoginIn.id);
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(fontSize: 18, fontFamily: "Pacifico"),
                    ),
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
