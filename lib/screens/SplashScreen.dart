import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win75/components/pages.dart';

import 'authentication.dart';
import 'intro.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/splashScreen";
  @override
  _Splash createState() => _Splash();
}

final storage = FlutterSecureStorage();

class _Splash extends State<SplashScreen> {
//  Future<String> jwtOrEmpty() async {
//    var jwt = await storage.read(key: "jwt");
//    if (jwt == null) return "";
//    return jwt;
//  }

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
          child: SpinKitCubeGrid(
        color: Theme.of(context).accentColor,
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future<void> _handleStartScreen() async {
    String jwt = await storage.read(key: "jwt");
    if (jwt == null) {
      print("jwt is null");
      jwt = "";
    }
    if (jwt != "") {
      List jwtList = jwt.split(".");
      if (jwtList.length != 3) {
        print("jwt is invalid");
        Navigator.popAndPushNamed(context, AuthScreen.id);
      } else {
//        var payload = json.decode(
//          ascii.decode(
//            base64.decode(
//              base64.normalize(jwtList[1]),
//            ),
//          ),
//        );
        print("pushing");
        Navigator.popAndPushNamed(context, Pages.id, arguments: 1);
        print("puse=hed");
//        if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
//            .isAfter(DateTime.now())) {
//          Navigator.popAndPushNamed(context, Pages.id);
//        } else {
//          Navigator.popAndPushNamed(context, AuthScreen.id);
//        }
      }
    } else {
      Navigator.popAndPushNamed(context, AuthScreen.id);
    }
  }
}
