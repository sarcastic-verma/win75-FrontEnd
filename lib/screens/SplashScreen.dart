import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication.dart';
import 'home.dart';
import 'intro.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/splashScreen";
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      _handleStartScreen();
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushNamed(context, IntroScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 10,
          value: null,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future<void> _handleStartScreen() async {
//    Auth _auth = Auth();

    if (false) {
      Navigator.popAndPushNamed(context, HomeScreen.id);
    } else {
      Navigator.popAndPushNamed(context, AuthScreen.id);
    }
  }
}
