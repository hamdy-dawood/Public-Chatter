import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void navigateTo({
  required String page,
  bool withHistory = true,
  String? arguments,
}) {
  Navigator.pushNamedAndRemoveUntil(
    navigatorKey.currentContext!,
    page,
    arguments: arguments,
    (route) => withHistory,
  );
}
