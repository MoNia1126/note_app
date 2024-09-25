import 'package:note_app/data/model/my_user.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final MyUser myUser;
  final String message;

  RegisterSuccess(this.myUser, this.message);
}

class RegisterError extends RegisterState {
  final String errorMessage;

  RegisterError(this.errorMessage);
}
