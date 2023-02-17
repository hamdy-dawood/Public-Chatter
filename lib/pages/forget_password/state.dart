part of 'cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final String stateMsg;

  ForgetPasswordSuccessState({required this.stateMsg});
}

class ForgetPasswordFailureState extends ForgetPasswordState {
  final String stateMsg;

  ForgetPasswordFailureState({required this.stateMsg});
}
