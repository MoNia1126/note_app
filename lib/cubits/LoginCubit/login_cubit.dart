import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:note_app/cache_helper.dart';
import 'package:note_app/cubits/LoginCubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null && user.emailVerified) {
        CacheHelper.saveData(key: "userId", value: user.uid);
        emit(LoginSuccess());
      } else if (!user!.emailVerified) {
        await user.sendEmailVerification();
        emit(LoginError('Please verify your email to continue.'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
