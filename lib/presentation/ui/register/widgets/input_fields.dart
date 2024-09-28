import 'package:flutter/material.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputFields extends StatefulWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const InputFields({
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          prefixIcon: Icon(Icons.person, color: Colors.grey.shade300),
          hintText: AppLocalizations.of(context)!.enterYourUsername,
          label: AppLocalizations.of(context)!.userName,
          controller: widget.userNameController,
          validator: (text) {
            if (text == null || text.trim().isEmpty) {
              return AppLocalizations.of(context)!.pleaseEnterUserName;
            }
            return null;
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CustomTextFormField(
          prefixIcon: Icon(Icons.email, color: Colors.grey.shade300),
          hintText: AppLocalizations.of(context)!.enterYourEmail,
          label: AppLocalizations.of(context)!.email,
          keyboardType: TextInputType.emailAddress,
          controller: widget.emailController,
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
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CustomTextFormField(
          prefixIcon: Icon(Icons.password, color: Colors.grey.shade300),
          hintText: AppLocalizations.of(context)!.enterYourPassword,
          label: AppLocalizations.of(context)!.password,
          controller: widget.passwordController,
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
              return AppLocalizations.of(context)!
                  .passwordShouldHaveAtLeast6Chars;
            }
            return null;
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CustomTextFormField(
          prefixIcon: Icon(Icons.password, color: Colors.grey.shade300),
          hintText: AppLocalizations.of(context)!.enterYourConfirmationPassword,
          label: AppLocalizations.of(context)!.confirmPassword,
          controller: widget.confirmPasswordController,
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
              return AppLocalizations.of(context)!.pleaseEnterConfirmPassword;
            }
            if (text != widget.passwordController.text) {
              return AppLocalizations.of(context)!.passwordDoesNotMatch;
            }
            return null;
          },
        ),
      ],
    );
  }
}
