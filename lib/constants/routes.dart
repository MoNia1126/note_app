import 'package:flutter/material.dart';
import 'package:note_app/data/model/note.dart';
import 'package:note_app/presentation/ui/addNote/screens/add_note_bottom_sheet.dart';
import 'package:note_app/presentation/ui/editNote/screens/edit_note.dart';
import 'package:note_app/presentation/ui/home/screens/home_screen.dart';
import 'package:note_app/presentation/ui/login/screens/login_screen.dart';
import 'package:note_app/presentation/ui/noteDetails/screens/note_detail_page.dart';
import 'package:note_app/presentation/ui/noteList/screens/note_list_tab.dart';
import 'package:note_app/presentation/ui/register/screens/register_screen.dart';
import 'package:note_app/presentation/ui/settings/screens/setting_screen.dart';
import 'package:note_app/presentation/ui/splash/screens/splash_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String noteDetail = '/note-detail';
  static const String splash = '/splash';
  static const String editNote = '/edit-note';
  static const String addNote = '/add-note';
  static const String setting = '/setting';
  static const String noteListTab = '/note-list-tab';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case editNote:
        final args = settings.arguments as Note; // Expecting a Note argument
        return MaterialPageRoute(builder: (_) => EditNote(note: args));
      case noteDetail:
        final args = settings.arguments as Note;
        return MaterialPageRoute(builder: (_) => NoteDetailPage(note: args));
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case noteListTab:
        return MaterialPageRoute(builder: (_) => const NoteListTab());
      case addNote:
        return MaterialPageRoute(builder: (_) => const AddNoteBottomSheet());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
