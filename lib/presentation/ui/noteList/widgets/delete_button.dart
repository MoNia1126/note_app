import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_confirmation_dialog.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/data/model/note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';

class DeleteButton extends StatelessWidget {
  final Note note;

  const DeleteButton({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete, color: MyTheme.redColor, size: 30),
      onPressed: () => _showDeleteConfirmationDialog(context),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomConfirmationDialog(
          title: AppLocalizations.of(context)!.delete,
          content: AppLocalizations.of(context)!.areYouSureYouWantToDeleteNote,
          action1: AppLocalizations.of(context)!.delete,
          action2: AppLocalizations.of(context)!.cancel,
          onPressed: () {
            BlocProvider.of<NotesCubit>(context).deleteNote(note.noteId);
            Navigator.pop(context);
          },
          pressed: () {
            Navigator.pop(context, false);
          },
        );
      },
    );
  }
}
