import 'package:firebaseapp/data/local/prefs/pref_keys.dart';
import 'package:firebaseapp/data/local/prefs/pref_manager.dart';
import 'package:firebaseapp/utils/navigator/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 1000), () {
      PrefUtil.getBool(PrefKeys.LOGGED_IN).then((value) {
        if (value) {
          Keys.navKey.currentState.pushReplacementNamed(Routes.homeScreen);
        } else
          Keys.navKey.currentState.pushReplacementNamed(Routes.loginScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage("assets/images/profile.jpg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 300.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
