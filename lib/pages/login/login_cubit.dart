import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      emit(LoginLoadingState());

      bool? isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified;
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (isEmailVerified == true) {
        emit(LoginSuccessState(stateMsg: "Login Success"));
      } else {
        emit(LoginFailureState(stateMsg: 'Please verify your acc.'));
      }
    } on FirebaseAuthException catch (ex) {
      emit(LoginFailureState(stateMsg: ex.code.toString()));
    }
  }
}
