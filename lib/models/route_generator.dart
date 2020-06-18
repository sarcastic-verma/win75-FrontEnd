import 'package:flutter/material.dart';
import 'package:win75/screens/SplashScreen.dart';
import 'package:win75/screens/authentication.dart';
import 'package:win75/screens/connection.dart';
import 'package:win75/screens/home.dart';
import 'package:win75/screens/intro.dart';
import 'package:win75/screens/login.dart';
import 'package:win75/screens/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AuthScreen.id:
        return MaterialPageRoute(builder: (_) => AuthScreen());

//      case EditProfileScreen.id:
//        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LoginIn.id:
        return MaterialPageRoute(builder: (_) => LoginIn());
      case SignUp.id:
        return MaterialPageRoute(builder: (_) => SignUp());
//      case ProfileScreen.id:
////        if (args is User) {
//        return MaterialPageRoute(
//            builder: (_) => ProfileScreen(
////                    user: args,
//                ));
////        } else {
////          return MaterialPageRoute(builder: (_) => AuthScreen());
////        }
//        break;

      case IntroScreen.id:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case ConnectionLost.id:
        return MaterialPageRoute(builder: (_) => ConnectionLost());

// Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
// If args is not of the correct type, return an error page.
//        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
