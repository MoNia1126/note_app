import 'package:flutter/material.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;

  const EmailInputField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icon(Icons.email, color: Colors.grey.shade300),
      hintText: AppLocalizations.of(context)!.enterYourEmail,
      label: AppLocalizations.of(context)!.email,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterEmail;
        }
        bool emailValid = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        ).hasMatch(text);
        if (!emailValid) {
          return AppLocalizations.of(context)!.pleaseEnterAValidEmail;
        }
        return null;
      },
    );
  }
}
