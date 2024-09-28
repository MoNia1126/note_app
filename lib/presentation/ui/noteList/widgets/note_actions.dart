import 'package:flutter/material.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/ui/noteList/widgets/delete_button.dart';
import 'package:note_app/presentation/ui/noteList/widgets/edit_button.dart';

class NoteActions extends StatelessWidget {
  final Note note;

  const NoteActions({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DeleteButton(note: note),
        EditButton(note: note),
      ],
    );
  }
}
