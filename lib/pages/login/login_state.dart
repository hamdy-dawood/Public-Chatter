part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String stateMsg;

  LoginSuccessState({required this.stateMsg});
}

class LoginFailureState extends LoginState {
  final String stateMsg;

  LoginFailureState({required this.stateMsg});
}
