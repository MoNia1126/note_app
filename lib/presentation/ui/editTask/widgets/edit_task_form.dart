import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/editTask/widgets/data_picker.dart';
import 'package:note_app/presentation/ui/editTask/widgets/save_button.dart';

class EditTaskForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onSave;

  const EditTaskForm({
    required this.titleController,
    required this.descriptionController,
    required this.selectedDate,
    required this.onDateChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: screenSize.height * 0.7,
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
          children: [
            _buildFormTitle(context),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: titleController,
                    hintText: AppLocalizations.of(context)!.title,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterTitle;
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: descriptionController,
                    hintText: AppLocalizations.of(context)!.noteDescription,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterNoteDescription;
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                  DatePicker(
                    selectedDate: selectedDate,
                    onDateSelected: onDateChanged,
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  SaveButton(onPressed: onSave),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildFormTitle(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.editNote,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontFamily: 'PlaywriteCU',
            color: Theme.of(context).primaryColor,
          ),
    );
  }
}
