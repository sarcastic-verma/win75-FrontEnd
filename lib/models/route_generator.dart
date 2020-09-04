import 'package:flutter/material.dart';
import 'package:win75/components/pages.dart';
import 'package:win75/screens/About_Us.dart';
import 'package:win75/screens/FAQ.dart';
import 'package:win75/screens/PlayerSummaryDetails.dart';
import 'package:win75/screens/RefundPolicies.dart';
import 'package:win75/screens/Rules.dart';
import 'package:win75/screens/SplashScreen.dart';
import 'package:win75/screens/TnC.dart';
import 'package:win75/screens/authentication.dart';
import 'package:win75/screens/battlefield.dart';
import 'package:win75/screens/connection.dart';
import 'package:win75/screens/games_history.dart';
import 'package:win75/screens/intro.dart';
import 'package:win75/screens/login.dart';
import 'package:win75/screens/signup.dart';
import 'package:win75/screens/transactionHistory.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case FAQ.id:
        return MaterialPageRoute(builder: (_) => FAQ());
      case Rules.id:
        return MaterialPageRoute(builder: (_) => Rules());
      case AuthScreen.id:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case GamesHistory.id:
        return MaterialPageRoute(builder: (_) => GamesHistory());
      case TransactionHistory.id:
        return MaterialPageRoute(builder: (_) => TransactionHistory());

//      case EditProfileScreen.id:
//        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      case BattleFieldScreen.id:
        return MaterialPageRoute(builder: (_) => BattleFieldScreen());
      case Login.id:
        return MaterialPageRoute(builder: (_) => Login());
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
      case Pages.id:
        return MaterialPageRoute(
            builder: (_) => Pages(
                  currentTab: args,
                ));
      case IntroScreen.id:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case TnC.id:
        return MaterialPageRoute(builder: (_) => TnC());
      case RefundPolicies.id:
        return MaterialPageRoute(builder: (_) => RefundPolicies());
      case AboutUs.id:
        return MaterialPageRoute(builder: (_) => AboutUs());
      case PlayerSummaryDetails.id:
        return MaterialPageRoute(
            builder: (_) => PlayerSummaryDetails(
                  gameId: args,
                ));
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
