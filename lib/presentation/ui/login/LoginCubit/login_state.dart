import 'package:note_app/data/model/my_user.dart';

abstract class LoginState {
  final MyUser? currentUser;

  LoginState({this.currentUser});
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final MyUser user;

  LoginSuccess(this.user, this.message) : super(currentUser: user);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
