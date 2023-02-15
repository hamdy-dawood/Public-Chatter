import 'package:chats_app/constants.dart';

class Message {
  final String id;
  final String message;

  Message(
    this.id,
    this.message,
  );

  factory Message.fromJson(jsonData) {
    return Message(
      jsonData['id'],
      jsonData[kMessage],
    );
  }
}
