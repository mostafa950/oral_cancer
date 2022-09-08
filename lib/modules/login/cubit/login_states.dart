abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class ChangePasswordVisibilityLoginState extends LoginStates {}

class OralLoginLoadingState extends LoginStates {}

class OralLoginSuccessState extends LoginStates {
  final String? uId;
  OralLoginSuccessState(this.uId);

}

class OralLoginErrorState extends LoginStates {
  final String? error;

  OralLoginErrorState(this.error);

}
class OralSignInWithGoogleLoadingState extends LoginStates {}

class OralSignInWithGoogleSuccessState extends LoginStates {
  final String uId;

  OralSignInWithGoogleSuccessState(this.uId);

}

class OralSignInWithGoogleErrorState extends LoginStates {}

class OralSignInWithFacebookLoadingState extends LoginStates {}

class OralSignInWithFacebookSuccessState extends LoginStates {
  final String uId;

  OralSignInWithFacebookSuccessState(this.uId);

}

class OralSignInWithFacebookErrorState extends LoginStates {}
