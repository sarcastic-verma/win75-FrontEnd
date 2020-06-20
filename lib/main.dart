import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:true_time/true_time.dart';
import 'package:win75/models/route_generator.dart';
import 'package:win75/screens/SplashScreen.dart';
import 'package:win75/screens/connection.dart';
import 'package:win75/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

final storage = FlutterSecureStorage();
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

  bool _initialized = false;
  DateTime _currentTime;

  _initPlatformState() async {
    bool initialized = await TrueTime.init();
    setState(() {
      _initialized = initialized;
    });
    print(initialized);
    if (initialized) _updateCurrentTime();
  }

  _updateCurrentTime() async {
    DateTime now = await TrueTime.now();
    print(now);
    setState(() {
      _currentTime = now;
    });
    print(_currentTime);
  }

  @override
  void initState() {
    super.initState();
    _initPlatformState();
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
    return MaterialApp(
      navigatorKey: nav,
      theme: kDefaultTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: SplashScreen.id,
    );
  }
}
