import 'package:chats_app/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPrimaryColor,
      elevation: 0.0,
      content: Row(
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 1.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
  );
}
