import 'package:flutter/material.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/addNote/screens/add_note_bottom_sheet.dart';

class AddNoteFAB extends StatelessWidget {
  const AddNoteFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return const SingleChildScrollView(
              child: AddNoteBottomSheet(),
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        size: 33,
        color: MyTheme.whiteColor,
      ),
    );
  }
}
