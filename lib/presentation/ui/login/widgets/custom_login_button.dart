import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/presentation/ui/login/LoginCubit/login_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: AppLocalizations.of(context)!.login,
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (formKey.currentState!.validate()) {
          context
              .read<LoginCubit>()
              .signIn(context, emailController.text, passwordController.text);
        }
      },
    );
  }
}
