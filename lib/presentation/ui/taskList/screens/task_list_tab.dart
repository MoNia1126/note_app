import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_state.dart';
import 'package:note_app/presentation/ui/taskList/widgets/task_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        // if (state is NotesLoading) {
        //   return Center(
        //       child: CircularProgressIndicator(
        //     color: Theme.of(context).primaryColor,
        //   ));
        if (state is NotesLoaded) {
          List<Note> notes = state.notes;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskWidget(
                      note: notes[index],
                    );
                  },
                  itemCount: notes.length,
                ),
              )
            ],
          );
        } else if (state is NotesError) {
          return Center(child: Text((AppLocalizations.of(context)!.error)));
        } else {
          return Center(
            child: Text(""),
          );
        }
      },
    );
  }
}
