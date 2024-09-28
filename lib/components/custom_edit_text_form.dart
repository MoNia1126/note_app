import 'package:flutter/material.dart';
import 'package:note_app/constants/my_theme.dart';

class CustomEditTextForm extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final Color? cursorColor;
  final String? hintText;

  const CustomEditTextForm({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.cursorColor,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: Theme.of(context).primaryColor,
        selectionColor: Theme.of(context).primaryColor.withOpacity(0.5),
        selectionHandleColor: Theme.of(context).primaryColor,
      ),
      child: TextFormField(
        cursorColor: cursorColor ?? Theme.of(context).primaryColor,
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintStyle: TextStyle(
            color: MyTheme.grayColor,
          ),
        ),
      ),
    );
  }
}
