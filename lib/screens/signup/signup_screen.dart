import 'package:firebaseapp/data/models/app_state.dart';
import 'package:firebaseapp/data/models/user_profile.dart';
import 'package:firebaseapp/redux/actions/signup_action.dart';
import 'package:firebaseapp/utils/general_functions.dart';
import 'package:firebaseapp/utils/views/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class SignupScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final experienceController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SignupViewModel>(
        converter: (Store<AppState> store) {
      this.store = store;
      return _SignupViewModel.create(store, context);
    }, builder: (BuildContext context, _SignupViewModel model) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // ignore: sdk_version_ui_as_code
              if (model.isLoader)
                CustomLoader()
              else
                SizedBox.shrink(),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "model.user.uid",
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
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_box),
                                counterStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Name")),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                        child: TextField(
                            controller: experienceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.confirmation_number),
                                counterStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Experience")),
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
                                hintText: "Email")),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                        child: TextField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                counterStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Password")),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 16.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              backgroundColor: Colors.teal,
                              onPressed: () {
                                _signUp();
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void _signUp() {
    print("signup cliked");
    var email = emailController.text;
    var password = passwordController.text;
    var exp = experienceController.text;
    var name = nameController.text;

    if (name.isEmpty)
      Fluttertoast.showToast(msg: 'Please enter name');
    else if (exp.isEmpty)
      Fluttertoast.showToast(msg: 'Please enter experience');
    else if (email.isEmpty)
      Fluttertoast.showToast(msg: 'Please enter email');
    else if (!isValidEmail(email))
      Fluttertoast.showToast(msg: 'Not a valid email');
    else if (password.isEmpty)
      Fluttertoast.showToast(msg: 'Please enter password');
    else {
      var profile =
          UserProfile(email: email, experience: int.parse(exp), name: name);
      print("signup api hit");
      store.dispatch(SignupLoaderAction(true));
      store.dispatch(SignupAction(email, password, profile));
    }
  }
}

class _SignupViewModel {
  final bool isLoader;
  final Store<AppState> store;
  final String errMsg;
  final UserProfile user;

  _SignupViewModel(this.isLoader, this.store, this.errMsg, this.user);

  factory _SignupViewModel.create(Store<AppState> store, BuildContext context) {
    return _SignupViewModel(store.state.signupLoader, store, store.state.error,
        store.state.currentSignedUpUser);
  }
}
