import 'package:chats_app/pages/chat/cubit.dart';
import 'package:chats_app/pages/chat/view.dart';
import 'package:chats_app/pages/login/view.dart';
import 'package:chats_app/pages/register/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'helper/navigate_to_page.dart';
import 'pages/forget_password/view.dart';
import 'pages/splash/view.dart';
import 'pages/verify/view.dart';

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
    return BlocProvider(
      create: (context) => ChatCubit(),
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
          RegisterPage.id: (context) => RegisterPage(),
          ForgetPasswordPage.id: (context) => ForgetPasswordPage(),
          VerifyPage.id: (context) => const VerifyPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: SplashPage.id,
      ),
    );
  }
}
