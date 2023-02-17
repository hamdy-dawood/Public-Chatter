import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  Future<void> resetPassword({required String email}) async {
    try {
      emit(ForgetPasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgetPasswordSuccessState(stateMsg: "Message Sent ."));
    } on FirebaseException catch (e) {
      emit(ForgetPasswordFailureState(stateMsg: e.code.toString()));
    }
  }
}
