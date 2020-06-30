import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/data/local/prefs/pref_keys.dart';
import 'package:firebaseapp/data/local/prefs/pref_manager.dart';
import 'package:firebaseapp/data/models/app_state.dart';
import 'package:firebaseapp/data/models/user_profile.dart';
import 'package:firebaseapp/redux/actions/login_action.dart';
import 'package:firebaseapp/redux/actions/signup_action.dart';
import 'package:firebaseapp/utils/navigator/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAppMiddleware() {
  final logInGoogle = _createGoogleLogInMiddleware();
  final logInEmail = _createLoginWithEmail();
  final signupWithEmail = _emailSignup();
  final logOut = _createLogOutMiddleware();
  final updateUserDb = _updateUserDb();

  // Built in redux method that tells your store that these
  // are middleware methods.
  //
  // As the app grows, we can add more Auth related middleware
  // here.
  return ([
    new TypedMiddleware<AppState, LoginWithGoogle>(logInGoogle),
    new TypedMiddleware<AppState, LogInAction>(logInEmail),
    new TypedMiddleware<AppState, UpdateUserDbAction>(updateUserDb),
    new TypedMiddleware<AppState, SignupAction>(signupWithEmail),
    new TypedMiddleware<AppState, LogOut>(logOut)
  ]);
}

//..........................................Middleware methods.................................

// Now, we need to write those methods,which
// return a Middleware typed function.
//
//region Auth

Middleware<AppState> _emailSignup() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
    print("Signup starts");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (action is SignupAction) {
      try {
        var auth = await _auth.createUserWithEmailAndPassword(
            email: action.email, password: action.password);

        user = auth.user;

        var profile = action.userProfile;
        profile.id = user.uid;

        store.dispatch(UpdateUserDbAction(profile));

        print("Signup Done ${user.uid}");
        // save data inPrefs
        PrefUtil.addString(PrefKeys.USER_ID, user.uid);
        PrefUtil.setBool(PrefKeys.LOGGED_IN, true);
        PrefUtil.addObject(
            PrefKeys.USER_PROFILE,
            UserProfile(
                email: user.email, experience: 0, name: "Mr. Charles Xavier"));
      } on Exception catch (e) {
        store.dispatch(new SignupFailAction(e));
        print("Signup failed");
        Fluttertoast.showToast(msg: e.toString());
        store.dispatch(SignupLoaderAction(false));
      } finally {
        //store.dispatch(SignupLoaderAction(false));
      }
    }
  };
}

Middleware<AppState> _updateUserDb() {
  return (Store store, action, NextDispatcher next) async {
    final db = Firestore.instance;
    print("db starts");
    if (action is UpdateUserDbAction) {
      try {
        await db
            .collection("Employee")
            .document(action.userProfile.id)
            .setData(action.userProfile.toJson())
            .then((docRef) {
          print("db done");
          store.dispatch(SignupSucessful(action.userProfile));
          Keys.navKey.currentState.pushNamedAndRemoveUntil(
              Routes.homeScreen, (Route<dynamic> route) => false);
        }).catchError((onError) {
          Fluttertoast.showToast(msg: onError.message);
          print("db error ${onError.message}");
        });
      } on Exception catch (e) {
        store.dispatch(new SignupFailAction(e));
        print("db failed");
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        store.dispatch(SignupLoaderAction(false));
      }
    }
  };
}

Middleware<AppState> _createLoginWithEmail() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
    print("Login starts");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (action is LogInAction) {
      try {
        var auth = await _auth.signInWithEmailAndPassword(
            email: action.loginModel.email,
            password: action.loginModel.password);

        user = auth.user;
        print("Login done");
        Fluttertoast.showToast(msg: "Login Successful");
        // save data inPrefs
        PrefUtil.addString(PrefKeys.USER_ID, user.uid);
        PrefUtil.setBool(PrefKeys.LOGGED_IN, true);
        PrefUtil.addObject(
            PrefKeys.USER_PROFILE,
            UserProfile(
                email: user.email, experience: 0, name: "Mr. Charles Xavier"));
        Keys.navKey.currentState.pushNamedAndRemoveUntil(
            Routes.homeScreen, (Route<dynamic> route) => false);
      } on Exception catch (e) {
        print("Login fail");
        Fluttertoast.showToast(msg: e.toString());
        store.dispatch(new LogInFail(e));
      } finally {
        store.dispatch(LoginLoaderAction(false));
      }
    }
  };
}

Middleware<AppState> _createGoogleLogInMiddleware() {
  // These functions will always take
  // your store,
  // the action that's been dispatched
  // and the a special function called next.
  return (Store store, action, NextDispatcher next) async {
    // YOUR LOGIC HERE

    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    // GoogleSignIn is a specific sign in class.
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    if (action is LoginWithGoogle) {
      try {
        GoogleSignInAccount account = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
        await account.authentication;

        AuthCredential authCredential = GoogleAuthProvider.getCredential(
            idToken: googleSignInAuthentication.accessToken,
            accessToken: googleSignInAuthentication.idToken);

        final AuthResult authResult =
        await _auth.signInWithCredential(authCredential);
        user = authResult.user;

        print('Logged in ' + user.displayName);

        store.dispatch(LoginSuccessful(user: user));
      } catch (e) {
        store.dispatch(new LogInFail(e.message));
      }
    }

    // After you do whatever logic you need to do,
    // call this Redux built-in method,
    // It continues the redux cycle.
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    // YOUR LOGIC HERE
    // Temporary instance
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      print('logging out...');
      store.dispatch(new LogOutSuccessful());
    } catch (error) {
      print(error);
    }

    next(action);
  };
}
//endregion
