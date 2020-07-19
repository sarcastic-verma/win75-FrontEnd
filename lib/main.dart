import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:win75/models/route_generator.dart';
import 'package:win75/screens/SplashScreen.dart';
import 'package:win75/screens/connection.dart';
import 'package:win75/utilities/constants.dart';

import 'models/User.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription connectivitySubscription;

  ConnectivityResult _previousResult;
  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.push(
            MaterialPageRoute(builder: (BuildContext _) => ConnectionLost()));
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.push(
            MaterialPageRoute(builder: (BuildContext _) => SplashScreen()));
      }

      _previousResult = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>.value(
      value: User(
          points: 30,
          inWalletCash: 100,
          mobile: "90120930101",
          email: "loa",
          username: "lolo",
          image:
              'https://i-cdn.phonearena.com/images/articles/99670-image/Android-4.4-KitKat-official-wallpapers-available-for-download-here.jpg'),
      child: MaterialApp(
        navigatorKey: nav,
        theme: kDefaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
