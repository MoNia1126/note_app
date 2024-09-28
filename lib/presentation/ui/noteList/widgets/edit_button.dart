import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';

class EditButton extends StatelessWidget {
  final Note note;

  const EditButton({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 30),
      onPressed: () => _navigateToEditNotePage(context),
    );
  }

  Future<void> _navigateToEditNotePage(BuildContext context) async {
    final updatedNote = await Navigator.pushNamed(
      context,
      AppRoutes.editNote,
      arguments: note,
    );
    if (updatedNote != null && updatedNote is Note) {
      BlocProvider.of<NotesCubit>(context).updateNoteInList(updatedNote);
    }
  }
}
