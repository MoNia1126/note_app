import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String text;
   final void Function() onPressed;
  CustomTextButton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(
              color: Theme.of(context).primaryColor),
        ));
  }
}
