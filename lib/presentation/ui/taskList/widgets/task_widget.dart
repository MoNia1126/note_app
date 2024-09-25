import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_state.dart';
import 'package:note_app/presentation/ui/editTask/screens/edit_task.dart';

class TaskWidget extends StatefulWidget {
  final Note note;

  const TaskWidget({super.key, required this.note});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return InkWell(
      onTap: () async {
        final updatedNote = await Navigator.pushNamed(
            context, EditTask.routeName,
            arguments: widget.note);
        if (updatedNote != null && updatedNote is Note) {
          setState(() {
            BlocProvider.of<NotesCubit>(context).updateNoteInList(updatedNote);
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  height: MediaQuery.of(context).size.height * 0.099,
                  width: MediaQuery.of(context).size.height * 0.004,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.note.title,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.note.description,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            if (widget.note.noteId.isNotEmpty) {
                              BlocProvider.of<NotesCubit>(context)
                                  .deleteNote(widget.note.noteId);
                            } else {
                              print("Note ID is empty");
                            }
                          },
                          icon: Icon(Icons.delete,
                              size: 35, color: MyTheme.redColor));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
