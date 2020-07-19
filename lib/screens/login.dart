import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win75/components/pages.dart';
import 'package:win75/screens/signup.dart';

class LoginIn extends StatelessWidget {
  static const id = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
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
              Text(
                "Log in",
//                style: kAuthHeaderTextStyle,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    onPressed: () async {
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
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18, fontFamily: "Pacifico"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, SignUp.id);
                    },
                    child: Text(
                      "Sign Up",
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
