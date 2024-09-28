import 'package:flutter/material.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordInputField({required this.controller, super.key});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icon(Icons.password, color: Colors.grey.shade300),
      hintText: AppLocalizations.of(context)!.enterYourPassword,
      label: AppLocalizations.of(context)!.password,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey.shade300,
        ),
      ),
      obscureText: obscureText,
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterPassword;
        }
        if (text.length < 6) {
          return AppLocalizations.of(context)!.passwordShouldHaveAtLeast6Chars;
        }
        return null;
      },
    );
  }
}
