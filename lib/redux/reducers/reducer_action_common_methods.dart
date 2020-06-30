import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/data/models/user_profile.dart';
import 'package:firebaseapp/redux/actions/login_action.dart';
import 'package:firebaseapp/redux/actions/signup_action.dart';
import 'package:redux/redux.dart';

final loginLoaderReducer = TypedReducer<bool, LoginLoaderAction>(
    _loginLoaderActionReducer); // loader for login

final signupLoaderReducer = TypedReducer<bool, SignupLoaderAction>(
    _signupLoaderActionReducer); // loader for signup

final loginSuccessFulReducer =
    TypedReducer<FirebaseUser, LoginSuccessful>(_logIn); //  for login success
final signupSuccessFulReducer =
    TypedReducer<UserProfile, SignupSucessful>(_signup); //  for signup success

final loginFail =
    TypedReducer<dynamic, LogInFail>(_loginFailed); // login failed

bool _loginLoaderActionReducer(bool state, LoginLoaderAction action) {
  //login loader action
  return action.loginLoader;
}

bool _signupLoaderActionReducer(bool state, SignupLoaderAction action) {
  //login loader action
  return action.signupLoader;
}

// *NB -- We haven't actually added a user to the state yet.
FirebaseUser _logIn(FirebaseUser user, LoginSuccessful action) {
  return action.user;
}

UserProfile _signup(UserProfile user, SignupSucessful action) {
  return action.userProfile;
}

// This will just replace the user slice of state with null.
Null _logOut(FirebaseUser user, action) {
  return null;
}

dynamic _loginFailed(dynamic, LogInFail action) {
  return action.error;
}
