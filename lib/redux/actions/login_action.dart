import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/data/models/login_model.dart';
import 'package:flutter/foundation.dart';

class LogInAction {
  final LoginModel loginModel;

  LogInAction(this.loginModel);
}

class LoginWithGoogle {
}

class LoginLoaderAction {
  bool loginLoader;

  LoginLoaderAction(this.loginLoader);
}

class LoginLoader {
  final bool loader;

  LoginLoader(this.loader);
}

class LoginSuccessful {
  final FirebaseUser user;

  LoginSuccessful({@required this.user});

  @override
  String toString() {
    return 'LogIn{user: $user}';
  }
}

class LogInFail {
  final dynamic error;

  LogInFail(this.error);

  @override
  String toString() {
    return 'LogIn{There was an error loggin in: $error}';
  }
}

class LogOut {}

class LogOutSuccessful {
  LogOutSuccessful();

  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}
