import 'package:flutter/material.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: AppLocalizations.of(context)!.saveChanges,
      onPressed: onPressed,
    );
  }
}
