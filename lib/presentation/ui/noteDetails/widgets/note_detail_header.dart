import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';

class NoteDetailHeader extends StatelessWidget {
  final Note note;

  const NoteDetailHeader({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          note.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        IconButton(
          onPressed: () async {
            final updatedNote = await Navigator.pushNamed(
              context,
              AppRoutes.editNote,
              arguments: note,
            );

            if (updatedNote is Note) {
              BlocProvider.of<NotesCubit>(context)
                  .updateNoteInList(updatedNote);
            }
          },
          icon:
              Icon(Icons.edit, size: 25, color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
