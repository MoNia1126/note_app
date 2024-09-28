import 'package:flutter/material.dart';
import 'package:note_app/data/model/note.dart';

class NoteDescription extends StatelessWidget {
  final Note note;

  const NoteDescription({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      note.description,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).primaryColor,
          ),
      maxLines: null,
      overflow: TextOverflow.visible,
    );
  }
}
