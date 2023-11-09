import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('hhh');
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      print('kkkk');
      if (e.code == 'user-not-found') {
        print('jjj');
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        print('jjj');
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user.'));
      } else {
        print('ll');
        emit(LoginFailure(errorMessage: 'fireBase error'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'wrooong'));
    }
  }
}
