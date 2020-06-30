import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/data/models/user_profile.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppState {
  final bool isLoading;
  final bool loginLoader;
  final bool signupLoader;
  final dynamic error;
  final FirebaseUser currentLoggedInUser;
  final UserProfile currentSignedUpUser;

  const AppState(
      {this.isLoading,
      this.error,
      this.currentLoggedInUser,
      this.currentSignedUpUser,
      this.loginLoader,
      this.signupLoader});

  static initialAppState() => AppState(
      isLoading: false, error: null, loginLoader: false, signupLoader: false);

//  AppState copyWith(
//      {bool isLoading,
//      FirebaseUser currentUser,
//      bool loginLoader,
//      bool signupLoader}) {
//    return new AppState(
//      isLoading: isLoading ?? this.isLoading,
//      currentUser: currentUser ?? this.currentUser,
//      loginLoader: loginLoader ?? this.loginLoader,
//      signupLoader: signupLoader ?? this.signupLoader,
//    );
//  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, currentUser: $currentSignedUpUser}';
  }
}
