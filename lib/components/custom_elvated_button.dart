import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  String text;
  final void Function() onPressed;

  CustomElevatedButton({super.key, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff005698),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9))),
          ),
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          )),
    );
  }
}
