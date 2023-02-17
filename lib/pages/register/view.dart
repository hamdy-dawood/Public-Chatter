import 'package:chats_app/pages/register/cubit.dart';
import 'package:chats_app/pages/verify/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';
import '../../helper/navigate_to_page.dart';
import '../../helper/show_snack_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../chat/cubit.dart';
import '../chat/view.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  String? name, email, password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          navigateTo(page: VerifyPage.id, arguments: email, withHistory: false);
          isLoading = false;
        } else if (state is RegisterFailureState) {
          isLoading = false;
          showSnackBar(context, state.stateMsg);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          color: kPrimaryColor,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
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
                        'REGISTER',
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
                          // setState(() {});
                        },
                        icon: Icon(
                          isPassword ? Icons.visibility : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () async{
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(email: email!, password: password!);
                        } else {}
                      },
                      text: 'REGISTER',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        'already have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
