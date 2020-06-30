import 'package:firebaseapp/data/models/app_state.dart';
import 'package:firebaseapp/redux/reducers/reducer_action_common_methods.dart';

AppState appReducer(AppState previousState, action) {
  return new AppState(
    isLoading: false,
    currentLoggedInUser:
        loginSuccessFulReducer(previousState.currentLoggedInUser, action),
    currentSignedUpUser:
        signupSuccessFulReducer(previousState.currentSignedUpUser, action),
    loginLoader: loginLoaderReducer(previousState.loginLoader, action),
    signupLoader: signupLoaderReducer(previousState.signupLoader, action),
  );
}
