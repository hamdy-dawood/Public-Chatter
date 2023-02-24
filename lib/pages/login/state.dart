part of 'cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String stateMsg;

  LoginFailureState({required this.stateMsg});
}

class VisibilityChangeState extends LoginState {}
