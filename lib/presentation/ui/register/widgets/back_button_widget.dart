import 'package:flutter/material.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/login/screens/login_screen.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      },
      icon: Icon(Icons.arrow_back_ios_new, color: MyTheme.whiteColor),
    );
  }
}
