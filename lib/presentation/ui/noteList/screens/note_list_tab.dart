import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_state.dart';
import 'package:note_app/presentation/ui/noteList/widgets/note_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteListTab extends StatefulWidget {
  const NoteListTab({super.key});

  @override
  State<NoteListTab> createState() => _NoteListTabState();
}

class _NoteListTabState extends State<NoteListTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        } else if (state is NotesLoaded) {
          List<Note> notes = state.notes;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return NoteWidget(
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
