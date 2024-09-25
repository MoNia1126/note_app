// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:note_app/firebase_utils.dart';
// import 'package:note_app/home/home_screen.dart';
// import 'package:note_app/model/my_user.dart';
// import 'register_state.dart';
//
// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit() : super(RegisterInitial());
//
//   Future<void> register(BuildContext context, String email, String password, String userName) async {
//     try {
//       emit(RegisterLoading());
//
//       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       MyUser myUser = MyUser(
//         id: credential.user?.uid ?? '',
//         userName: userName,
//         email: email,
//       );
//
//       await FirebaseUtils.addUserToFireStore(myUser);
//
//       log('User registered successfully: ${myUser.userName}');
//
//       emit(RegisterSuccess(myUser, "Registration Successful"));
//       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
//
//     } on FirebaseAuthException catch (e) {
//       log('FirebaseAuthException: ${e.message}');
//       if (e.code == 'weak-password') {
//         emit(RegisterError('The password provided is too weak.'));
//       } else if (e.code == 'email-already-in-use') {
//         emit(RegisterError('The account already exists for that email.'));
//       } else {
//         emit(RegisterError(e.message ?? 'Registration failed. Please try again.'));
//       }
//     } catch (e) {
//       log('Error: $e');
//       emit(RegisterError('Registration failed. Please try again.'));
//     }
//   }
// }

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/my_user.dart';
import 'package:note_app/data/services/firebase_utils.dart';
import 'package:note_app/presentation/ui/home/screens/home_screen.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(BuildContext context, String email, String password,
      String userName) async {
    try {
      emit(RegisterLoading());

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        userName: userName,
        email: email,
      );

      await FirebaseUtils.addUserToFireStore(myUser);

      log('User registered successfully: ${myUser.userName}');

      emit(RegisterSuccess(myUser, "Registration Successful"));
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message}');
      if (e.code == 'weak-password') {
        emit(RegisterError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterError('The account already exists for that email.'));
      } else {
        emit(RegisterError(
            e.message ?? 'Registration failed. Please try again.'));
      }
    } catch (e) {
      log('Error: $e');
      emit(RegisterError('Registration failed. Please try again.'));
    }
  }
}
