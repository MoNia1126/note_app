import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/components/custom_text_button.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/presentation/ui/register/screens/register_screen.dart';

class SignUpOption extends StatelessWidget {
  const SignUpOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.doNotHaveAnAccount,
            style: Theme.of(context).textTheme.titleMedium),
        CustomTextButton(
          text: AppLocalizations.of(context)!.signUp,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.register);
          },
        ),
      ],
    );
  }
}
