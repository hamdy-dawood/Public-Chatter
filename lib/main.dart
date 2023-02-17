import 'package:chats_app/pages/chat_page.dart';
import 'package:chats_app/pages/login/login_cubit.dart';
import 'package:chats_app/pages/login/login_view.dart';
import 'package:chats_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'helper/navigate_to_page.dart';
import 'pages/forget_password_page.dart';
import 'pages/splash_page.dart';
import 'pages/verify_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScholarChat();
  }
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Public Chatter",
        navigatorKey: navigatorKey,
        theme: ThemeData(
          platform: TargetPlatform.iOS,
        ),
        routes: {
          LoginPage.id: (context) => LoginPage(),
          SplashPage.id: (context) => const SplashPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          ForgetPasswordPage.id: (context) => const ForgetPasswordPage(),
          VerifyPage.id: (context) => const VerifyPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: SplashPage.id,
      ),
    );
  }
}
