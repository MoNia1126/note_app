import 'package:flutter/material.dart';
import 'package:note_app/presentation/ui/settings/widgets/custom_language_container.dart';
import 'package:note_app/presentation/ui/settings/widgets/custom_logout.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomLanguageContainer(),
              SizedBox(height: 40),
              CustomLogout(),
            ]));
  }
}
