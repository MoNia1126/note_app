import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_edit_text_form.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/ui/editNote/widgets/custom_appBar.dart';
import 'package:note_app/presentation/ui/editNote/widgets/save_button.dart';
import 'package:note_app/presentation/ui/editNote/widgets/selected_date.dart';

class EditNote extends StatefulWidget {
  final Note note;

  const EditNote({super.key, required this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the note's data
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    selectedDate = widget.note.dateTime;
  }

  @override
  void dispose() {
    titleController.dispose(); // Dispose of the controllers
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: (AppLocalizations.of(context)!.editNote)),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              height: screenSize.height * 0.1,
              color: Theme.of(context).primaryColor),
          SingleChildScrollView(
            child: Container(
              height: screenSize.height * 0.7,
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.08,
                  vertical: screenSize.height * 0.04),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyTheme.whiteColor),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    (AppLocalizations.of(context)!.editNote),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontFamily: 'PlaywriteCU',
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomEditTextForm(
                                  controller: titleController,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return (AppLocalizations.of(context)!
                                          .pleaseEnterTitle);
                                    }
                                    return null;
                                  },
                                  hintText:
                                      (AppLocalizations.of(context)!.title))),
                          SizedBox(height: screenSize.height * 0.03),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomEditTextForm(
                              controller: descriptionController,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return (AppLocalizations.of(context)!
                                      .pleaseEnterNoteDescription);
                                }
                                return null;
                              },
                              hintText: (AppLocalizations.of(context)!
                                  .noteDescription),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.05),
                          const SelectedDate(),
                          SizedBox(height: screenSize.height * 0.08),
                          SaveButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                var updatedNote = Note(
                                  noteId: widget.note.noteId, // Use widget.note
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  dateTime: selectedDate,
                                );

                                // Update the note object and call the cubit
                                BlocProvider.of<NotesCubit>(context)
                                    .editNote(updatedNote);
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
