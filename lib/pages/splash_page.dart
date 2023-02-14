import 'dart:async';

import 'package:chats_app/constants.dart';
import 'package:chats_app/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../helper/navigate_to_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static String id = 'Splash page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  _goNext() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      navigateTo(page: LoginPage.id, withHistory: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Image(
                image: AssetImage(kLogo),
                fit: BoxFit.fill,
              ),
            ),
            Spacer(),
            Text(
              'Public Chatter App',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
