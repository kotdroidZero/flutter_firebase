import 'package:flutter/material.dart';

//define key used to navigate to routes...to be used globally
class Keys {
  static final navKey = GlobalKey<NavigatorState>();
}

class Routes {
  static final loginScreen = "/LoginScreen";
  static final signupScreen = "/SignupScreen";
  static final homeScreen = "/HomeScreen";
}
