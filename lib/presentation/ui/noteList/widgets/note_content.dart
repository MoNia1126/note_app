import 'package:flutter/material.dart';
import 'package:note_app/data/model/note.dart';

class NoteContent extends StatelessWidget {
  final Note note;

  const NoteContent({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${note.dateTime.day}/${note.dateTime.month}/${note.dateTime.year} "
        "${note.dateTime.hour}:${note.dateTime.minute}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            note.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ) ??
                TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            note.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ) ??
                TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(formattedDate,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ))),
      ],
    );
  }
}
