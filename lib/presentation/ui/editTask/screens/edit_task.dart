import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  static const String routeName = 'edit_task';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKey = GlobalKey<FormState>();

  late Note note;

  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  String title = "";
  String description = "";

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      note = ModalRoute.of(context)!.settings.arguments as Note;
      titleController.text = note.title;
      descriptionController.text = note.description;
      selectedDate = note.dateTime;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          (AppLocalizations.of(context)!.editNote),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontFamily: 'PlaywriteCU'),
        ),
      ),
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
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: titleController,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return (AppLocalizations.of(context)!
                                      .pleaseEnterTitle);
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText:
                                      (AppLocalizations.of(context)!.title)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: descriptionController,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return (AppLocalizations.of(context)!
                                      .pleaseEnterNoteDescription);
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: (AppLocalizations.of(context)!
                                      .noteDescription)),
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
                                    .copyWith(color: Colors.black)),
                          ),
                          InkWell(
                            onTap: () {
                              showCalendar();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${selectedDate.day}/"
                                  "${selectedDate.month}/"
                                  "${selectedDate.year}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black)),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.05),
                          CustomElevatedButton(
                              text: (AppLocalizations.of(context)!.saveChanges),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  // var noteId = FirebaseFirestore.instance
                                  //     .collection('users')
                                  //     .doc(userId)
                                  //     .collection('Note')
                                  //     .doc()
                                  //     .id;
                                  var updatedNote = Note(
                                    noteId: note.noteId,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    dateTime: selectedDate,
                                  );
                                  note.title = titleController.text;
                                  note.description = descriptionController.text;
                                  note.dateTime = selectedDate;
                                  BlocProvider.of<NotesCubit>(context)
                                      .editNote(updatedNote);
                                  Navigator.pop(context);
                                }
                              })
                        ],
                      ))
                ],
              ),
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
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:note_app/data/model/note.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
// import 'package:note_app/presentation/ui/editTask/widgets/custom_appBar.dart';
// import 'package:note_app/presentation/ui/editTask/widgets/edit_task_form.dart';
//
// class EditTask extends StatefulWidget {
//   const EditTask({super.key});
//
//   static const String routeName = 'edit_task';
//
//   @override
//   State<EditTask> createState() => _EditTaskState();
// }
//
// class _EditTaskState extends State<EditTask> {
//   late Note note;
//   DateTime selectedDate = DateTime.now();
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       note = ModalRoute.of(context)!.settings.arguments as Note;
//       titleController.text = note.title;
//       descriptionController.text = note.description;
//       selectedDate = note.dateTime;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: CustomAppBar(title: AppLocalizations.of(context)!.editNote),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Container(
//             height: screenSize.height * 0.1,
//             color: Theme.of(context).primaryColor,
//           ),
//           EditTaskForm(
//             titleController: titleController,
//             descriptionController: descriptionController,
//             selectedDate: selectedDate,
//             onDateChanged: (newDate) {
//               setState(() {
//                 selectedDate = newDate;
//               });
//             },
//             onSave: () => _saveNote(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _saveNote() {
//     final updatedNote = Note(
//       noteId: note.noteId,
//       title: titleController.text,
//       description: descriptionController.text,
//       dateTime: selectedDate,
//     );
//     BlocProvider.of<NotesCubit>(context).editNote(updatedNote);
//     Navigator.pop(context);
//   }
// }
