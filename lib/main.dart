import 'package:flutter/material.dart';
import 'package:win75/models/route_generator.dart';
import 'package:win75/screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: SplashScreen.id,
    );
  }
}
