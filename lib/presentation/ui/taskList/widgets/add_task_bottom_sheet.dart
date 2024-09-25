import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_state.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Container(
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
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return (AppLocalizations.of(context)!.pleaseEnterTitle);
                      }
                      title = text;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: (AppLocalizations.of(context)!.enterNoteTitle),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return (AppLocalizations.of(context)!
                            .pleaseEnterNoteDescription);
                      }
                      description = text;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText:
                          (AppLocalizations.of(context)!.enterNoteDescription),
                    ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    (AppLocalizations.of(context)!.selectDate),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCalendar();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                BlocBuilder<NotesCubit, NotesState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      text: (AppLocalizations.of(context)!.add),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
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
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
