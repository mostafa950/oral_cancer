abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class ChangePasswordVisibilityRegisterState extends RegisterStates {}

class OralRegisterLoadingState extends RegisterStates {}

class OralRegisterSuccessState extends RegisterStates {}

class OralRegisterErrorState extends RegisterStates {
  final String? error;

  OralRegisterErrorState(this.error);
}

class OralCreateUserSuccessState extends RegisterStates {}

class OralCreateUserErrorState extends RegisterStates {}



