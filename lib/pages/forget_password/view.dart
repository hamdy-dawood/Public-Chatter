import 'package:chats_app/pages/forget_password/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';
import '../../helper/show_snack_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {

  static String id = 'forget password page';
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Builder(
          builder: (context) {
            final cubit = ForgetPasswordCubit.get(context);
            return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordLoadingState) {
                  isLoading = true;
                } else if (state is ForgetPasswordSuccessState) {
                  showSnackBar(context, state.stateMsg);
                  isLoading = false;
                } else if (state is ForgetPasswordFailureState) {
                  isLoading = false;
                  showSnackBar(context, state.stateMsg);
                }
              },
              builder: (context, state) {
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
                                  cubit.resetPassword(email: email!);
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
              },
            );
          }
      ),
    );
  }
}
