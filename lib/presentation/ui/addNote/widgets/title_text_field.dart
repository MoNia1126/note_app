import 'package:flutter/material.dart';
import 'package:note_app/components/custom_edit_text_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleTextField extends StatefulWidget {
  final TextEditingController titleController;

  const TitleTextField({required this.titleController, super.key});

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomEditTextForm(
        validator: (text) {
          if (text == null || text.isEmpty) {
            return (AppLocalizations.of(context)!.pleaseEnterTitle);
          }
          return null;
        },
        controller: widget.titleController,
        hintText: (AppLocalizations.of(context)!.enterNoteTitle),
      ),
    );
  }
}
