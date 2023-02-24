import 'package:chats_app/helper/navigate_to_page.dart';
import 'package:chats_app/pages/forget_password/view.dart';
import 'package:chats_app/pages/login/cubit.dart';
import 'package:chats_app/pages/register/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';
import '../../helper/show_snack_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../chat/cubit.dart';
import '../chat/view.dart';

class LoginPage extends StatelessWidget {
  static String id = 'login page';
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(builder: (context) {
        final cubit = LoginCubit.get(context);
        return BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              isLoading = true;
            } else if (state is LoginSuccessState) {
              BlocProvider.of<ChatCubit>(context).getMessage();
              navigateTo(
                  page: ChatPage.id, arguments: email, withHistory: false);
              isLoading = false;
            } else if (state is LoginFailureState) {
              isLoading = false;
              showSnackBar(context, state.stateMsg);
            }
          },
          builder: (context, state) => ModalProgressHUD(
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
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return CustomFormTextField(
                            onChanged: (data) {
                              password = data;
                            },
                            label: 'Password',
                            isLastInput: true,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.changeVisibility();
                                },
                                icon: Icon(
                                  cubit.isPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                )),
                            obscureText: cubit.isPassword,
                          );
                        },
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
                            cubit.loginUser(email: email!, password: password!);
                          }
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
          ),
        );
      }),
    );
  }
}
