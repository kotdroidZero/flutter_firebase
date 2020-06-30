import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/data/models/app_state.dart';
import 'package:firebaseapp/data/models/login_model.dart';
import 'package:firebaseapp/redux/actions/login_action.dart';
import 'package:firebaseapp/utils/general_functions.dart';
import 'package:firebaseapp/utils/navigator/routes.dart';
import 'package:firebaseapp/utils/views/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _LoginViewModel>(
        converter: (Store<AppState> store) {
      this.store = store;
      return _LoginViewModel.create(store, context);
    }, builder: (BuildContext context, _LoginViewModel model) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // ignore: sdk_version_ui_as_code
                      if (model.isLoader)
                        CustomLoader()
                      else
                        SizedBox.shrink(),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FlutterLogo(
                        size: 100.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                        child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                counterStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Enter Email")),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                        child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                counterStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Enter Password")),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 16.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              backgroundColor: Colors.teal,
                              onPressed: () {
                                _login();
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Keys.navKey.currentState
                              .pushNamed(Routes.signupScreen);
                        },
                        child: Text(
                          "New member ? Register here.",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void _login() {
    print("login clicked");
    var email = emailController.text;
    var password = passwordController.text;

    if (email.isEmpty)
      Fluttertoast.showToast(msg: 'Please enter email');
    else if (!isValidEmail(email))
      Fluttertoast.showToast(msg: 'Not a valid email');
    else if (password.isEmpty)
      Fluttertoast.showToast(msg: 'Please enter password');
    else {
      print("login api hit");
      store.dispatch(LoginLoaderAction(true));
      store.dispatch(LogInAction(LoginModel(email: email, password: password)));
      print("login api action");
    }
  }
}

class _LoginViewModel {
  final bool isLoader;
  final Store<AppState> store;
  final String errMsg;
  final FirebaseUser user;

  _LoginViewModel(this.isLoader, this.store, this.errMsg, this.user);

  factory _LoginViewModel.create(Store<AppState> store, BuildContext context) {
    return _LoginViewModel(store.state.loginLoader, store, store.state.error,
        store.state.currentLoggedInUser);
  }
}
