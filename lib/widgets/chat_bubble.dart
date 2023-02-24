import 'package:chats_app/models/message.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.icon,
  }) : super(key: key);
  final Message message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: kPrimaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.id,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "  ${message.message}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(
              icon,
              color: Colors.deepPurple,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    Key? key,
    required this.message,
    required this.icon,
  }) : super(key: key);
  final Message message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          color: Color(0xff006D84),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.id,
              style: TextStyle(
                color: Colors.orange[300],
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${message.message}  ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(
              icon,
              color: Colors.orange[300],
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
