import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/presentation/cubits/NotesCubit/notes_cubit.dart';
import 'package:note_app/presentation/cubits/changeLanguageCubit/change_language_state.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/cubits/changeLanguageCubit/change_language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChangeLanguageCubit>(
          create: (context) => ChangeLanguageCubit(),
        ),
        BlocProvider<NotesCubit>(
          create: (context) => NotesCubit()..loadNotes(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Notes App',
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: MyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          locale: state.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
