import 'package:flutter/material.dart';
import 'package:note_app/components/custom_edit_text_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionTextField extends StatefulWidget {
  final TextEditingController descriptionController;

  const DescriptionTextField({super.key, required this.descriptionController});

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomEditTextForm(
        validator: (text) {
          if (text == null || text.isEmpty) {
            return (AppLocalizations.of(context)!.pleaseEnterNoteDescription);
          }

          return null;
        },
        hintText: (AppLocalizations.of(context)!.enterNoteDescription),
        maxLines: 3,
      ),
    );
  }
}
