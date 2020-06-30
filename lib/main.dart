import 'package:firebaseapp/redux/middleware/middleware.dart';
import 'package:firebaseapp/redux/reducers/app_reducers.dart';
import 'package:firebaseapp/screens/home/home_screen.dart';
import 'package:firebaseapp/screens/login/login_screen.dart';
import 'package:firebaseapp/screens/signup/signup_screen.dart';
import 'package:firebaseapp/screens/splash/SplashScreen.dart';
import 'package:firebaseapp/utils/constants.dart';
import 'package:firebaseapp/utils/navigator/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'data/models/app_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String tittle = 'Firebase';

  final store = Store<AppState>(appReducer,
      initialState: AppState.initialAppState(),
      middleware: createAppMiddleware());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: tittle,
          initialRoute: Constants.ROUTE_SPLASH,
          navigatorKey: Keys.navKey,
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            Routes.signupScreen: (context) {
              return SignupScreen();
            },
            Routes.loginScreen: (context) {
              return LoginScreen();
            },
            Routes.homeScreen: (context) {
              return HomeScreen();
            }
          },
        ));
  }
}
