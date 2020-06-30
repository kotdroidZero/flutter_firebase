import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/data/models/user_profile.dart';

class SignupAction {
  final String email;
  final String password;
  final UserProfile userProfile;

  SignupAction(this.email, this.password, this.userProfile);
}

class UpdateUserDbAction {
  final UserProfile userProfile;

  UpdateUserDbAction(this.userProfile);
}

class SignupLoaderAction {
  bool signupLoader;

  SignupLoaderAction(this.signupLoader);
}

class SignupFailAction {
  final dynamic error;

  SignupFailAction(this.error);
}

class SignupSucessful {
  final UserProfile userProfile;

  SignupSucessful(this.userProfile);
}
