import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/message.dart';

part 'state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void sendMessage({
    required String message,
    required String email,
  }) {
    try {
      messages.add(
        {
          kMessage: message,
          kCreatedAt: DateTime.now(),
          'id': email,
        },
      );
    } on Exception catch (e) {
      emit(ChatFailureState());
    }
  }

  void getMessage() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccessState(messages: messagesList));
    });
  }
}
