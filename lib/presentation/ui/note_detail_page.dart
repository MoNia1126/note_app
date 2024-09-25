import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/ui/editTask/screens/edit_task.dart';

class NoteDetailPage extends StatefulWidget {
  static const String routeName = 'note_detail_page';

  const NoteDetailPage({super.key});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          (AppLocalizations.of(context)!.details),
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
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              // height: screenSize.height * 0.84,
              width: screenSize.width * 0.9,
              margin: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.08,
                vertical: screenSize.height * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyTheme.whiteColor,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note.title,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  // fontFamily: 'PlaywriteCU',
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                      IconButton(
                          onPressed: () async {
                            final updatedNote = await Navigator.pushNamed(
                                context, EditTask.routeName);
                            if (updatedNote != null && updatedNote is Note) {
                              setState(() {
                                BlocProvider.of<NotesCubit>(context)
                                    .updateNoteInList(updatedNote);
                              });
                            }
                          },
                          icon: Icon(Icons.edit,
                              size: 25, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    note.description,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
