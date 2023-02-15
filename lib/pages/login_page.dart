import 'package:chats_app/helper/navigate_to_page.dart';
import 'package:chats_app/pages/forget_password_page.dart';
import 'package:chats_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String id = 'login page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  bool isPassword = true;

  // bool isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: kPrimaryColor,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  kLogo,
                  height: 150,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'LOGIN',
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
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  obscureText: isPassword,
                  onChanged: (data) {
                    password = data;
                  },
                  label: 'Password',
                  isLastInput: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      isPassword = !isPassword;
                      setState(() {});
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      navigateTo(
                        page: ForgetPasswordPage.id,
                      );
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});

                      await loginUser();

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(
                          page: RegisterPage.id,
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
       bool? isEmailVerified =FirebaseAuth.instance.currentUser?.emailVerified;

      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      if (isEmailVerified == true) {
        navigateTo(page: ChatPage.id, arguments: email, withHistory: false);
      } else {
        showSnackBar(context, 'Please verify your acc.');
      }
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        showSnackBar(context, 'user not found');
      } else if (ex.code == 'wrong-password') {
        showSnackBar(context, 'wrong password');
      } else {
        showSnackBar(context, 'there was an error');
      }
    } catch (ex) {
      print(ex);
      showSnackBar(context, 'there was an error');
    }
  }
}
