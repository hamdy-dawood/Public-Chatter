import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  static String id = 'forget password page';

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: kPrimaryColor,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
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
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (data) {
                    email = data;
                  },
                  label: 'Email',
                  isLastInput: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '- We will send you a message to reset your new password.',
                  style: TextStyle(
                    fontSize: 13,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      await resetPassword();
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Send',
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      showSnackBar(context, 'Reset link sent.');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.code);
    }
  }
}
