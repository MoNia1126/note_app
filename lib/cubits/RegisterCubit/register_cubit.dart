import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:note_app/cubits/RegisterCubit/register_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        await user.sendEmailVerification();
        emit(RegisterSuccess());
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
