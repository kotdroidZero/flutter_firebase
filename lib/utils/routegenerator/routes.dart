//import 'package:firebaseapp/screens/error/error_screen.dart';
//import 'package:firebaseapp/screens/home/home_screen.dart';
//import 'package:firebaseapp/screens/login/login_screen.dart';
//import 'package:firebaseapp/screens/signup/signup_screen.dart';
//import 'package:firebaseapp/screens/splash/SplashScreen.dart';
//import 'package:flutter/material.dart';
//
//import '../constants.dart';
//
/////  class for route navigation in all over the project
//class RouteGenerator {
//  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
//    final args = routeSettings.arguments;
//
//    switch (routeSettings.name) {
//      case Constants.ROUTE_SPLASH:
//        return MaterialPageRoute(builder: (_) => SplashScreen());
//      case Constants.ROUTE_LOGIN:
//        return MaterialPageRoute(builder: (_) => LoginScreen());
//      case Constants.ROUTE_SIGNUP:
//        return MaterialPageRoute(builder: (_) => SignupScreen());
//      case Constants.ROUTE_HOME:
//        return MaterialPageRoute(builder: (_) => HomeScreen(args));
//      default:
//        return MaterialPageRoute(builder: (_) => ErrorScreen());
//    }
//  }
//
//  static void navigate(
//      BuildContext buildContext, String route, Object arguments) {
//    if (route == Constants.ROUTE_HOME) {
//      Navigator.of(buildContext)
//          .pushReplacementNamed(route, arguments: arguments);
//    } else {
//      Navigator.of(buildContext).pushNamed(route, arguments: arguments);
//    }
//  }
//}
