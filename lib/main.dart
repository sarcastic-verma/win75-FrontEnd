import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:win75/models/GamesProvider.dart';
import 'package:win75/models/route_generator.dart';
import 'package:win75/screens/SplashScreen.dart';
import 'package:win75/screens/connection.dart';
import 'package:win75/utilities/GameService.dart';
import 'package:win75/utilities/auth.dart';
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
    getCurrentUserAndGames();
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

  User user;
  GamesProvider gamesProvider;
  final AuthService authService = AuthService();
  void getCurrentUserAndGames() async {
    print("hila");
    User result = await authService.getUserFromSharedPreferences();
    GamesProvider gamesProviderResult =
        await GameService.getGameFromSharedPreferences();
    setState(() {
      user = result;
      gamesProvider = gamesProviderResult;
      String name = user.username;
      print('name: $name');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GamesProvider>.value(
            value: GamesProvider(
          played4to5: gamesProvider != null ? gamesProvider.played4to5 : "",
          played3to4: gamesProvider != null ? gamesProvider.played3to4 : "",
          played5to6: gamesProvider != null ? gamesProvider.played5to6 : "",
        )),
        ChangeNotifierProvider<User>.value(
          value: User(
              uid: user != null ? user.uid : null,
              games: user != null ? user.games : null,
              transactions: user != null ? user.transactions : null,
              referralCode: user != null ? user.referralCode : null,
              totalAmountSpent: user != null ? user.totalAmountSpent : null,
              totalAmountWon: user != null ? user.totalAmountWon : null,
              disabled: user != null ? user.disabled : null,
              joinedOn: user != null ? user.joinedOn : null,
              points: user != null ? user.points : null,
              inWalletCash: user != null ? user.inWalletCash : null,
              mobile: user != null ? user.mobile : null,
              email: user != null ? user.email : null,
              username: user != null ? user.username : null,
              image: user != null ? user.image : null),
        )
      ],
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
