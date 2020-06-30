import 'package:firebaseapp/data/local/prefs/pref_keys.dart';
import 'package:firebaseapp/data/local/prefs/pref_manager.dart';
import 'package:firebaseapp/utils/navigator/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
//  final String title;

  //Future<UserProfile> profile;

  @override
  Widget build(BuildContext context) {
//    PrefUtil.getObject(PrefKeys.USER_PROFILE).then((profile) {
//      this.profile = profile;
//    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Charles"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                PrefUtil.setBool(PrefKeys.LOGGED_IN, false);
                Keys.navKey.currentState.pushNamedAndRemoveUntil(
                    Routes.loginScreen, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
        ));
  }
}
