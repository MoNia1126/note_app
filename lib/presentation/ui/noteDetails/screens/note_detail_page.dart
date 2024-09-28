import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/ui/noteDetails/widgets/note_description.dart';
import 'package:note_app/presentation/ui/noteDetails/widgets/note_detail_header.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;

  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.details,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontFamily: 'PlaywriteCU'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
              constraints: const BoxConstraints(maxWidth: 600),
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
                  NoteDetailHeader(note: note), // Use the passed note directly
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  NoteDescription(note: note), // Use the passed note directly
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
