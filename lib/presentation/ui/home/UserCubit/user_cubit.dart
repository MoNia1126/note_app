import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/data/model/my_user.dart';
import 'package:note_app/data/services/firebase_utils.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> fetchUserName() async {
    emit(UserLoading());
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(UserError("User is not logged in."));
        return;
      }
      MyUser? user = await FirebaseUtils.fetchUserById(userId);
      if (user != null) {
        emit(UserLoaded(user.userName));
      } else {
        emit(UserError("User data not found."));
      }
    } catch (e) {
      emit(UserError("Failed to fetch user data: ${e.toString()}"));
    }
  }
}
