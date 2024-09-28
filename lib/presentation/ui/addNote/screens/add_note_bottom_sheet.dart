import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_edit_text_form.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_state.dart';
import 'package:note_app/presentation/ui/noteList/widgets/date_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNoteBottomSheet extends StatefulWidget {
  const AddNoteBottomSheet({super.key});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              (AppLocalizations.of(context)!.addNewNote),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: 'PlaywriteCU',
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomEditTextForm(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return (AppLocalizations.of(context)!
                              .pleaseEnterTitle);
                        }
                        title = text;
                        return null;
                      },
                      hintText: (AppLocalizations.of(context)!.enterNoteTitle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomEditTextForm(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return (AppLocalizations.of(context)!
                              .pleaseEnterNoteDescription);
                        }
                        description = text;
                        return null;
                      },
                      hintText:
                          (AppLocalizations.of(context)!.enterNoteDescription),
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DatePicker(
                      initialDate: selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ),
                  BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        text: (AppLocalizations.of(context)!.add),
                        onPressed: () => _onAddNotePressed(context, userId),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddNotePressed(BuildContext context, String? userId) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('Title: $title');
      print('Description: $description');
      var noteId = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Note')
          .doc()
          .id;
      final note = Note(
        title: title,
        description: description,
        dateTime: selectedDate,
        noteId: noteId,
      );
      BlocProvider.of<NotesCubit>(context).addNote(note);
      Navigator.pop(context);
    }
  }
}
