import 'dart:async';

import 'package:chats_app/helper/navigate_to_page.dart';
import 'package:chats_app/pages/login_page.dart';
import 'package:chats_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);
  static String id = 'VerifyPage';

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(minutes: 10), (timer) {});
    emailVerified();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              kLogo,
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verify Account !',
                style: TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                'Email send to :',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                '${user.email}',
                style:  TextStyle(
                  color: Colors.blue[800],
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              onTap: () {
                navigateTo(
                  page: LoginPage.id,
                );
              },
              text: 'Back To LOGIN',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> emailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    timer.cancel();
    if (user.emailVerified) {
      navigateTo(page: LoginPage.id, withHistory: false);
    }
  }
}
