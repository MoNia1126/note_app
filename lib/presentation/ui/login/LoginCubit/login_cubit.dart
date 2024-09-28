import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/services/firebase_utils.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      emit(LoginLoading());

      // if (!await isEmailRegistered(email)) {
      //   emit(LoginFailure('Email not found.'));
      //   return;
      // }

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user =
          await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? '');

      if (user == null) {
        emit(LoginFailure('No user found for that email.'));
        return;
      }

      log('User logged in: ${user.userName} (ID: ${user.id})');
      emit(LoginSuccess(user, "Login Successful"));
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Exception: ${e.code}');
      switch (e.code) {
        case 'user-not-found':
          emit(LoginFailure('No user found for that email.'));
          break;
        case 'wrong-password':
          emit(LoginFailure('Wrong password provided.'));
          break;
        default:
          emit(LoginFailure(e.message ?? 'Login failed. Please try again.'));
      }
    } catch (e) {
      log('Login Exception: $e');
      emit(LoginFailure('Login failed. Please try again.'));
    }
  }

// Future<bool> isEmailRegistered(String email) async {
//   try {
//     final QuerySnapshot result = await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .get();
//
//     log('Email check result: ${result.docs.length}');
//     return result.docs.isNotEmpty;
//   } catch (e) {
//     log('Error checking email: $e');
//     return false;
//   }
// }
}
