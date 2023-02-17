part of 'cubit.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatSuccessState extends ChatState {
  List<Message> messages = [];

  ChatSuccessState({required this.messages});
}

class ChatFailureState extends ChatState {}
