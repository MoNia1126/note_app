import 'package:flutter/material.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/noteList/widgets/color_indicator.dart';
import 'package:note_app/presentation/ui/noteList/widgets/note_actions.dart';
import 'package:note_app/presentation/ui/noteList/widgets/note_content.dart';

class NoteWidget extends StatefulWidget {
  final Note note;

  const NoteWidget({super.key, required this.note});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToNoteDetail(context),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            ColorIndicator(),
            const SizedBox(width: 10),
            Expanded(child: NoteContent(note: widget.note)),
            NoteActions(note: widget.note),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: MyTheme.whiteColor,
    );
  }

  Future<void> _navigateToNoteDetail(BuildContext context) async {
    Navigator.pushNamed(
      context,
      AppRoutes.noteDetail,
      arguments: widget.note,
    );
  }
}
